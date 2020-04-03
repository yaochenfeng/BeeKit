//
//  BeeAppDelegate.m
//  BeeKit
//
//  Created by yaochenfeng on 2020/2/28.
//

#import "BeeAppDelegate.h"

#import <objc/runtime.h>
#import <objc/message.h>
@interface BeeAppDelegate()
@property (nonatomic, strong) NSMutableDictionary<NSString*, id<UIApplicationDelegate>> *delegateMap;
@end

@implementation BeeAppDelegate
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init {
    if (self = [super init]) {
        self.delegateMap = [NSMutableDictionary dictionary];
        [self loadConfig];
    }
    return self;
}
- (void)loadConfig {
    NSString *mainConfig = [[NSBundle mainBundle] pathForResource:@"BeeKitConfig" ofType:@"plist"];
    if(!mainConfig){
        return;
    }
    NSDictionary *mainPlist = [NSDictionary dictionaryWithContentsOfFile:mainConfig];
    NSArray *delegates = [mainPlist mutableArrayValueForKey:@"AppDelegate"];
    for (NSDictionary *dict in delegates){
        [self addProxyFromConfig:dict];
    }
}
-(void)addProxyFromConfig:(NSDictionary *) dict {
    NSString *framework = [dict objectForKey:@"framework"];
    NSString *clsname = [dict objectForKey:@"class"];
    NSString *name = [dict objectForKey:@"name"];
    NSString *classFullName = clsname;
    if(!clsname || !name){
        return;
    }
    if(framework){
        classFullName = [NSString stringWithFormat:@"%@.%@",framework,classFullName];
    }
    Class handlerClass =  NSClassFromString(classFullName);
    id<UIApplicationDelegate> obj = nil;
    if([handlerClass conformsToProtocol:@protocol(UIApplicationDelegate)]){
        obj = [handlerClass new];
        [self add:obj name:name];
    }
}

- (NSArray<NSString *> *)appDelegateMethods {
    static NSMutableArray *methods = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unsigned int methodCount = 0;
        struct objc_method_description *methodList = protocol_copyMethodDescriptionList(@protocol(UIApplicationDelegate), NO, YES, &methodCount);
        methods = [NSMutableArray arrayWithCapacity:methodCount];
        for (int i = 0; i < methodCount; i ++) {
            struct objc_method_description md = methodList[i];
            [methods addObject:NSStringFromSelector(md.name)];
        }
        free(methodList);
    });
    return methods;
}

- (void)add:(id<UIApplicationDelegate>) delegate name:(NSString *)name {
    if(!delegate || !name){
        return;
    }
    self.delegateMap[name] = delegate;
}
- (nullable id<UIApplicationDelegate>)delegateForName:(NSString*) name{
    return self.delegateMap[name];
}


- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL canResponse = [super respondsToSelector:aSelector];
    if (! canResponse && [[self appDelegateMethods] containsObject:NSStringFromSelector(aSelector)]) {
        canResponse = [self proxyCanResponseToSelector:aSelector];
    }
    return canResponse;
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    [self proxyForwardInvocation:anInvocation];
}

- (BOOL)proxyCanResponseToSelector:(SEL)aSelector {
    __block BOOL response = false;
    [self.delegateMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<UIApplicationDelegate> _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:aSelector]) {
            response = true;
            *stop = YES;
        }
    }];
    return response;
}
- (void)proxyForwardInvocation:(NSInvocation *)anInvocation {
    
    [self.delegateMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<UIApplicationDelegate> _Nonnull obj, BOOL * _Nonnull stop) {
        if ( ! [obj respondsToSelector:anInvocation.selector]) {
            return;
        }
        [anInvocation invokeWithTarget:obj];
    }];
    // todo return value
}

-(void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"%@ doesNotRecognizeSelector", NSStringFromSelector(aSelector));
}
@end

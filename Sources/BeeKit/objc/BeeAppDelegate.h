//
//  BeeAppDelegate.h
//  BeeKit
//
//  Created by yaochenfeng on 2020/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeeAppDelegate : UIResponder<UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
- (void)add:(id<UIApplicationDelegate>) delegate name:(NSString *)name;
- (nullable id<UIApplicationDelegate>)delegateForName:(NSString*) name;
+ (instancetype)sharedInstance;
@end
NS_ASSUME_NONNULL_END

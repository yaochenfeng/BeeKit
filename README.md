# BeeKit

A Kit for iOS developer.

<p align="center">
   <a href="https://travis-ci.org/yaochenfeng/BeeKit">
      <img src="https://travis-ci.org/yaochenfeng/BeeKit.svg" alt="Travis CI Status">
   </a>
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0">
   </a>
   <a href="https://cocoapods.org/pods/BeeKit">
      <img src="https://img.shields.io/cocoapods/v/BeeKit.svg?style=flat" alt="Version">
   </a>
   <a href="https://cocoapods.org/pods/BeeKit">
      <img src="https://img.shields.io/cocoapods/p/BeeKit.svg?style=flat" alt="Platform">
   </a>
   <a href="https://github.com/Carthage/Carthage">
      <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage Compatible">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>

Task
====

- [x] Add Carthage、CocoaPods、Swift Package Manager support
- [x] Add Router for Controller
- [ ] Create documentation


## Usage
### Router
get object for url
```swift
URLRouter.shared.objectFor(type: UIViewController.Type, url: <#T##URL?#>)
```
show controller for url
```swift
URLRouter.shared.open(<#T##url: URL?##URL?#>, source: UIViewController.bee.topVisibleViewController(), options: <#T##[String : Any]?#>)
```

URLRouterable
```swift
extension WebViewController: URLRouterable {
    /** optional
    var bee_router: String = "beelink://nativePage/webview"
    */
    static func initWith(_ url: URL, options: [String : Any]?) -> UIViewController? {
        return WebViewController(url)
    }
}
```

URLRouterSchemeAble
```swift
extension WebViewController: URLRouterable {
    static var bee_scheme: String = "http,https"
    
    static func initWith(scheme url: URL, options: [String : Any]?) -> UIViewController? {
        return WebViewController(url)
    }
}
```

## Installation
### [CocoaPods](http://cocoapods.org) 

> CocoaPods 1.8.4+ is recommand to build BeeKit.

To integrate SnapKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
target '<Your Target Name>' do
  pod 'BeeKit'
end
```
Replace YOUR_TARGET_NAME and then run a `pod install` inside your terminal, or from CocoaPods.app.

### [Carthage](https://github.com/Carthage/Carthage)

Add this to `Cartfile`

```
github "yaochenfeng/BeeKit"
```

Run `carthage update` to build the framework and drag the built `BeeKit.framework` into your Xcode project.

#### Carthage as a Static Library

Carthage defaults to building BeeKit as a Dynamic Library. 

If you wish to build BeeKit as a Static Library using Carthage you may use the script below to manually modify the framework type before building with Carthage:

```bash
carthage update RxSwift --platform iOS --no-build
sed -i -e 's/MACH_O_TYPE = mh_dylib/MACH_O_TYPE = staticlib/g' Carthage/Checkouts/BeeKit/BeeKit.xcodeproj/project.pbxproj
carthage build BeeKit --platform iOS
```

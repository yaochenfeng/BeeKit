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

#### Optional Sources
```bash
$ pod cache clean BeeKit
$ IS_SOURCE_BeeKit=1 pod install
```

### [Carthage](https://github.com/Carthage/Carthage)

Add this to `Cartfile`

```
github "yaochenfeng/BeeKit"
```

Run `carthage update` to build the framework and drag the built `BeeKit.framework` into your Xcode project.
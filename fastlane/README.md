fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios release_candidate
```
fastlane ios release_candidate
```
Description of what the lane does
### ios github_after_deploy
```
fastlane ios github_after_deploy
```
github_after_deploy
### ios prepare_release
```
fastlane ios prepare_release
```
prepare_release munual

####Options

 * **`version`** (required): The new version of the framework

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

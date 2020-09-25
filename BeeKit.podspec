# https://guides.cocoapods.org/syntax/podspec.html
Pod::Spec.new do |s|
  s.name                      = "BeeKit"
  s.version                   = "0.2.0"
  s.summary                   = "Bee"
  s.homepage                  = "https://github.com/yaochenfeng/BeeKit"
  s.license = {
    :type => 'MIT',
    :text => <<-LICENSE
            copyright MIT
    LICENSE
  }
  s.author                    = { "yaochenfeng" => "282696845@qq.com" }
  s.ios.deployment_target     = "8.0"
  s.source                    = { :git => "https://github.com/yaochenfeng/BeeKit.git", :tag => s.version.to_s }
  if ENV['USE_BINARY_ALL'] || ENV['USE_BINARY_'+s.name.to_s]
    s.source                    = { :http => "https://github.com/yaochenfeng/BeeKit/releases/download/#{s.version}/BeeKit.framework.zip" }
    s.vendored_frameworks = 'Carthage/Build/iOS/*.framework'
  else
    s.source_files              = "Sources/BeeKit/{Foundation,Logging}/**/*.swift"
    s.ios.source_files   = 'Sources/BeeKit/iOS/**/*.swift'
    s.dependency 'RxCocoa'
  end
  s.frameworks                = "Foundation"
  s.swift_versions = ['5.0']
end

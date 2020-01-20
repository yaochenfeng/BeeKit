Pod::Spec.new do |s|
  s.name                      = "BeeKit"
  s.version                   = "0.0.4"
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
  if ENV['USE_BINARY_ALL'] || ENV['USE_BINARY_'+s.name.to_s]
    s.source                    = { :http => "https://github.com/yaochenfeng/BeeKit/releases/download/#{s.version}/BeeKit.framework.zip" }
    s.vendored_frameworks = 'Carthage/Build/iOS/*.framework'
  else
    s.source                    = { :git => "https://github.com/yaochenfeng/BeeKit.git", :tag => s.version.to_s }
    s.source_files              = "Sources/BeeKit/**/*.swift"
  end
  s.frameworks                = "Foundation"
  s.swift_versions = ['5.0']
end

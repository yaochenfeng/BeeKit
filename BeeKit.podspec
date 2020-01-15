Pod::Spec.new do |s|
  s.name                      = "BeeKit"
  s.version                   = "0.0.1"
  s.summary                   = "Bee"
  s.homepage                  = "https://github.com/yaochenfeng/BeeKit"
  s.license = {
    :type => 'MIT',
    :text => <<-LICENSE
            copyright MIT
    LICENSE
  }
  s.author                    = { "yaochenfeng" => "282696845@qq.com" }
  s.ios.deployment_target     = "9.0"
  if ENV['IS_SOURCE_ALL'] || ENV['IS_SOURCE_'+s.name.to_s]
    s.source                    = { :git => "https://github.com/yaochenfeng/BeeKit.git", :tag => s.version.to_s }
    s.source_files              = "Sources/BeeKit/**/*"
  else
    s.source                    = { :http => "https://github.com/yaochenfeng/BeeKit/releases/download/#{s.version}/BeeKit.framework.zip" }
    s.vendored_frameworks = 'Carthage/Build/iOS/*.framework'
  end
  s.frameworks                = "Foundation"
  s.swift_versions = ['5.0']
end

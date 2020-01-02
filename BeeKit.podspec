Pod::Spec.new do |s|
  s.name                      = "BeeKit"
  s.version                   = "0.1.0"
  s.summary                   = "Bee"
  s.homepage                  = "https://github.com/yaochenfeng/BeeKit"
  s.license = {
    :type => 'MIT',
    :text => <<-LICENSE
            copyright MIT
    LICENSE
  }
  s.author                    = { "yaochenfeng" => "282696845@qq.com" }
  s.source                    = { :git => "https://github.com/yaochenfeng/BeeKit.git", :tag => s.version.to_s }
  s.ios.deployment_target     = "9.0"
  s.source_files              = "Sources/BeeKit/**/*"
  s.frameworks                = "Foundation"
  s.swift_versions = ['5.0']
end

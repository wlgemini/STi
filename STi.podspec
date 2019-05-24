
Pod::Spec.new do |s|
  s.name                    = "STi"
  s.version                 = "1.0.0"
  s.summary                 = "Swift template for iOS app."
  s.homepage                = "https://github.com/wlgemini/STi"
  s.license                 = { :type => "MIT", :file => "LICENSE" }
  s.author                  = { "wlgemini" => "wangluguang@live.com" }
  s.platform                = :ios, "10.0"
  s.source                  = { :git => "https://github.com/wlgemini/STi.git", :tag => s.version.to_s }
  s.ios.deployment_target   = '10.0'
  s.source_files            = 'STi/Classes/**/*'
  s.swift_version           = '5.0'
  s.frameworks              = "UIKit"
  
  s.dependency              "Alamofire"
  s.dependency              "Driftwood"
  s.dependency              "Kingfisher"
  s.dependency              "SwiftyNavigationBar"
  s.dependency              "PKHUD"
  
end

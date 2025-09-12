require "json"
package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "siprocalsdk-reactnative-plugin"
  s.version      = "4.28.8"
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]
  s.platforms    = { :ios => '13.0' }
  s.source         = { :http => 'file:' + __dir__ + '/ios' }
  s.source_files = "ios/SiprocalsdkReactnativePlugin.{h,m,mm,swift}"
  s.public_header_files = 'ios/SiprocalsdkReactnativePlugin.h'
  s.dependency 'React-Core'
  s.ios.vendored_frameworks = 'ios/DigitalReefSDK.xcframework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework DigitalReefSDK'}
end

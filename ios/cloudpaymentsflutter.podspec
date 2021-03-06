#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cloudpaymentsflutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cloudpaymentsflutter'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for CloudPayments service'
  s.description      = <<-DESC
Flutter plugin for CloudPayments service
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.dependency 'Flutter'
  s.dependency 'SDK-iOS'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
  s.public_header_files = 'Classes/**/runner-bridging-header.h'
end

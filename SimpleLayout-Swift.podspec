#
# Be sure to run `pod lib lint SimpleLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleLayout-Swift'
  s.version          = '1.2.0'
  s.summary          = 'SimpleLayout helps you to using auto layout very easily.'
  s.description      = 'SimpleLayout helps you to using auto layout very easily.'
  s.homepage         = 'https://github.com/pisces/SimpleLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Steve Kim' => 'hh963103@@gmail.com' }
  s.source           = { :git => 'https://github.com/pisces/SimpleLayout.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'SimpleLayout/Classes/**/*'
end

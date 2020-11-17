#
# Be sure to run `pod lib lint FantasmoSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FantasmoSDK'
  s.version          = '0.1.0'
  s.summary          = 'Hyper-accurate global positioning for cameras.'
  s.description      = 'FantasmoSDK description goes here…'

  s.homepage         = 'https://github.com/fantasmoio/Fantasmo-iOS-SDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'krishn' => 'krishn@github.io' }
  s.source           = { :git => 'https://krishn-fantasmo@github.com/fantasmoio/Fantasmo-iOS-SDK.git', :branch => 'master' }

  s.ios.deployment_target = '11.0'
  s.swift_version    = '4.2'

  s.source_files = 'FantasmoSDK/Classes/**/*.{h,m,swift}'
  s.resources = "FantasmoSDK/Assets/*.xcassets"
  s.dependency 'Alamofire', '~> 5.0.0'
  s.dependency 'BrightFutures'
end

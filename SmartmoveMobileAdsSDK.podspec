#
# Be sure to run `pod lib lint SmartmoveMobileAdsSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SmartmoveMobileAdsSDK'
  s.version          = '2.1.3'
  s.summary          = 'A short description of SmartmoveMobileAdsSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/oneweekstudio/SmartmoveMobileAdsSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'oneweekstudio' => 'dongnd@smartmove.com.vn' }
  s.source           = { :git => 'https://github.com/oneweekstudio/SmartmoveMobileAdsSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SmartmoveMobileAdsSDK/Classes/**/*'
  
  s.ios.resource_bundle = { 'SmartmoveMobileAdsSDK' => 'Assets/**/*.png' }

  s.resource_bundles = {
     'SmartmoveMobileAdsSDK' => ['SmartmoveMobileAdsSDK/Assets/*']
   }
  s.static_framework = true
  
  #s.subspec 'SMADResources' do |resources|
   #   resources.resource_bundle = {'SmartmoveMobileAdsSDK' => ['SmartmoveMobileAdsSDK/**/*.{png,storyboard}']}
 # end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'SwiftyBeaver'
   s.ios.dependency 'Alamofire'
   s.ios.dependency 'MagicMapper', "~> 1.0.2"
   s.ios.dependency 'SDWebImage'
end

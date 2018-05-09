#
# Be sure to run `pod lib lint DlOemMoudle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DlOemMoudle'
    s.version          = '0.1.0'
    s.summary          = '小行家马甲包组件'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    小行家马甲包组件，主要是针对上架等问题。
    DESC
    
    s.homepage         = 'https://github.com/ZZN/DlOemMoudle'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'ZZN' => 'dream_at@sina.com' }
    s.source           = { :git => 'git@gitee.com:ios_components/DlOemMoudle.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.requires_arc = true
    s.ios.deployment_target = '8.0'
    s.platform = :ios,'8.0'
    s.source_files = 'DlOemMoudle/Classes/**/*.{h,m,swift}'
    
    s.resource_bundles = {
        'DlOemMoudleRes' => ['DlOemMoudle/Assets/**/*.{storyboard}']
    }
    
    s.resources = 'DlOemMoudle/Assets/dloem.bundle/**/*.{*}'
    
    s.public_header_files = 'DlOemMoudle/Classes/**/*.{h}'
    s.module_name = 'DlOemMoudle'
    #s.frameworks = 'UIKit','Foundation'
    s.pod_target_xcconfig = {
        'SWIFT_VERSION' => '4.0',
    }
    
    s.dependency  'FSCalendar'
    s.dependency  'SwiftDate'
    s.dependency  'RxSwift'
    s.dependency  'RxCocoa'
    s.dependency  'Alamofire'
    s.dependency  'SwiftyJSON'
    s.dependency  'SVProgressHUD'
    s.dependency  'BlocksKit'
    s.dependency  'SnapKit'

    s.dependency  'Realm'
    s.dependency  'MBProgressHUD'
    s.dependency  'YYModel'
    s.dependency  'NSObject-SafeExpectations'
    
    
end

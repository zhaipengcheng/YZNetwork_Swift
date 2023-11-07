# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'YZNetwork_Swift' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for YZNetwork_Swift
  
  # 网络请求框架
  # https:https://github.com/Moya/Moya
  # pod 'Moya'
  pod 'Moya/RxSwift'

  # 避免每个界面定义disposeBag
  # https://github.com/RxSwiftCommunity/NSObject-Rx
  pod "NSObject+Rx"

  # JSON解析为对象
  # https://github.com/alibaba/HandyJSON
  pod "HandyJSON"
  # pod "SwiftyJSON"
  # pod "ObjectMapper"

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end

  
end

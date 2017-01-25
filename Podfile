# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'HyperRecipesDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HyperRecipesDemo
  pod 'Moya'
  pod 'RxSwift'
  pod 'Moya/RxSwift'
  pod 'Moya-ObjectMapper/RxSwift', :git => 'https://github.com/ivanbruel/Moya-ObjectMapper'
  pod 'RealmSwift'
  pod 'Reachability', :git => 'https://github.com/ashfurrow/Reachability.git', :branch => 'frameworks'
  pod 'SwifterSwift'
  pod 'SVProgressHUD'
  pod 'SwiftGen'
  pod 'Reusable'
  pod 'Kingfisher', '~> 3.0'
  
  target 'HyperRecipesDemoTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'ObjectMapper'
    pod 'RealmSwift'
  end

  target 'HyperRecipesDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

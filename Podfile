platform :ios, '11.4'
inhibit_all_warnings!

target 'MovieRama' do
  use_frameworks!

  pod 'Alamofire'
  pod 'DifferenceKit'

  pod 'MaterialComponents'

  pod 'ReactiveCocoa'
  pod 'ReactiveSwift'
  
  pod 'SnapKit'
  pod 'SwiftGen'
  pod 'SwiftyUserDefaults'
  pod 'Swinject'

  target 'MovieRamaTests' do
    inherit! :search_paths

      pod 'Nimble'
      pod 'Quick'
  end

  target 'MovieRamaUITests' do
    inherit! :search_paths

      pod 'Nimble'
      pod 'Quick'
  end

end

target 'MovieRamaCommon' do
  use_frameworks!

  pod 'ReactiveSwift'
  
  pod 'SwiftGen'

  target 'MovieRamaCommonTests' do
    inherit! :search_paths

      pod 'Nimble'
      pod 'Quick'
  end

end

target 'MovieRamaModels' do
  use_frameworks!

  pod 'Alamofire'

  pod 'ReactiveSwift'
  
  pod 'SwiftyUserDefaults'

  target 'MovieRamaModelsTests' do
    inherit! :search_paths

      pod 'Nimble'
      pod 'Quick'
  end

end

target 'MovieRamaViewModels' do
  use_frameworks!

  pod 'ReactiveSwift'

  target 'MovieRamaViewModelsTests' do
    inherit! :search_paths

      pod 'Nimble'
      pod 'Quick'
  end

end

target 'MoviewRamaViews' do
  use_frameworks!

  pod 'DifferenceKit'

  pod 'MaterialComponents'

  pod 'ReactiveCocoa'
  pod 'ReactiveSwift'

  pod 'SnapKit'

  target 'MoviewRamaViewsTests' do
    inherit! :search_paths

      pod 'Nimble'
      pod 'Quick'
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.1'
        end
    end
end

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

def common
  pod 'PKHUD'
  pod 'Fabric'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SwiftGen'
  pod 'SwiftLint'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  pod 'Crashlytics'
  pod 'STZPopupView'
  pod 'SwiftyBeaver'
  pod 'KeychainSwift'
  pod 'Firebase/Core'
  pod 'SimpleAnimation'
  pod 'IQKeyboardManager'
  pod 'SwiftyUserDefaults'
  pod 'AlamofireObjectMapper'
end

target 'modoTube' do
  common
  pod 'CVCalendar'
end

abstract_target :unit_tests do
  target 'UnitTests'
  common
end


# Copy acknowledgements to the Settings.bundle

post_install do | installer |
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.1'
      end
    end
  require 'fileutils'

  pods_acknowledgements_path = 'Pods/Target Support Files/Pods-modoTube/Pods-modoTube-acknowledgements.plist'

  puts 'pwd => ' + pods_acknowledgements_path
  settings_bundle_path = Dir.glob("**/*Settings.bundle*").first

  if File.file?(pods_acknowledgements_path)
    puts 'Copying acknowledgements to Settings.bundle'
    FileUtils.cp_r(pods_acknowledgements_path, "#{settings_bundle_path}/Acknowl\
edgements.plist", :remove_destination => false)
  end
end


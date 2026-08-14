
Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "hosted-ios-plugin"
  spec.version      = "1.0.0"
  spec.summary      = "Plugin hosted-ios-plugin."
  spec.swift_versions   = ['5.0']
  spec.description  = "Payment Transactions is processed using this plugin"
  spec.homepage     = "https://github.com/alinmapaypg/iOS-Hosted-Plugin"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

   spec.author             = { 'AlinmaPay' => 'techsupport@clickpay.sa' }

  # spec.platform     = :ios
   spec.platform     = :ios, "12.0"

  #  When using multiple platforms
   spec.ios.deployment_target = "12.0"


  spec.source       = { :git => 'https://github.com/alinmapaypg/iOS-Hosted-Plugin.git', :tag => spec.version.to_s }


  spec.source_files  = 'hosted-ios-plugin/Sources/**/*.{swift,h,m}'
  spec.exclude_files = "Classes/Exclude"

  spec.resources = 'hosted-ios-plugin/Sources/**/*.storyboard'


   spec.framework  = 'UIKit'
 
end

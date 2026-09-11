
Pod::Spec.new do |spec|


  spec.name         = "hosted-ios-alinmapay"
  spec.version      = "1.0.0"
  spec.summary      = "Plugin hosted-ios-plugin."
  spec.swift_versions   = ['5.0']
 spec.description  = "Payment transactions are processed using the AlinmaPay Hosted iOS Payment Plugin."

  spec.homepage     = "https://github.com/Sftcpg/Native_iOS_Alinmapay_Hosted"
  

  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

   spec.author             = { 'AlinmaPay' => 'alinmapaypg@gmail.com' }

  # spec.platform     = :ios
   spec.platform     = :ios, "12.0"

  #  When using multiple platforms
   spec.ios.deployment_target = "12.0"


  spec.source       = { :git => 'https://github.com/Sftcpg/Native_iOS_Alinmapay_Hosted.git', :tag => spec.version.to_s }


  spec.source_files  = 'hosted-ios-plugin/Sources/**/*.{swift,h,m}'
  spec.exclude_files = "Classes/Exclude"

  spec.resources = 'hosted-ios-plugin/Sources/**/*.storyboard'


   spec.framework  = 'UIKit'
 
end

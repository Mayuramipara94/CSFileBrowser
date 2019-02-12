
Pod::Spec.new do |s|
  s.name             = 'CSFileBrowser'
  s.version          = '0.1.2'
  s.summary          = 'This is an iOS library that shows an image,Pdf,Audio,Video.'
  s.swift_version    = '4.2'
  s.platform         = :ios

  s.description      = <<-DESC
TODO: This is an iOS library that shows an image,Pdf,Audio,Video with a page count. Users can scroll through local and remote         image,Pdf,Audio,Video.
                       DESC

  s.homepage         = 'https://github.com/Mayuramipara94/CSFileBrowser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mayur Amipara' => 'mayur.amipara@coruscate.co.in' }
  s.source           = { :git => 'https://github.com/Mayuramipara94/CSFileBrowser.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.2" }
  s.requires_arc = true
  
  #s.source_files = 'CSFileBrowser/Classes/**/*'
  
  s.source_files = 'CSFileBrowser/Classes/**/*.{swift}'
  s.resource_bundles = {
      'CSFileBrowser' => ['CSFileBrowser/Classes/**/*.{storyboard,xib,xcassets,json,imageset,png}']
  }
  
  s.frameworks = 'UIKit', 'AVKit'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end

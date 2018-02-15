Pod::Spec.new do |s|
  s.name             = 'SuperSaaSObjCSDK'
  s.version          = '0.1.0'
  s.summary          = 'Online bookings/appointments/calendars using the SuperSaaS scheduling platform.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Online appointment scheduler for any type of business. Flexible and affordable booking software that can be integrated into any site. Free basic version.
                       DESC

  s.homepage         = 'https://www.supersaas.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Travis Dunn' => 'travis@supersaas.com' }
  s.source           = { :git => 'https://github.com/TertiumQuid/SuperSaaSObjCSDK.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/supersaas'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'

  s.source_files = 'SuperSaaSObjCSDK/Classes/**/*'
end

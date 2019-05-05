#
# Be sure to run `pod lib lint Gradient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Gradient'
  s.version          = '0.1.0'
  s.summary          = 'Gradient Label & Gradient Button'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Make a gradient label or button simple
                       DESC

  s.homepage         = 'https://github.com/Rex-121/Gradient'
  s.screenshots     = 'https://github.com/Rex-121/Gradient/screenshots_1'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tyrant' => 'rex_wzc@163.com' }
  s.source           = { :git => 'https://github.com/Rex-121/Gradient.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'

  s.source_files = 'Gradient/**/*'

end

require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = 'react-native-ios-file-opener'
  s.version      = package['version']
  s.summary      = package['description']
  s.authors      = { "VampireGod" => "mashuai_hy@163.com" }
  s.homepage     = package['homepage']
  s.license      = package['license']
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/GodVampire/react-native-ios-file-opener.git" }
  s.source_files = 'ios/**/*.{h,m}'
  s.dependency 'React'
end

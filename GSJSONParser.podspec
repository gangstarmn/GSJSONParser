 Pod::Spec.new do |s|
  s.name         = "GSJSONParser"
  s.version      = "0.2.4"
  s.summary      = "GSJSONParser is JSON Object mapper"
  s.description  = <<-DESC
                    JSON object mapper from NSDictionary.
                   DESC
  s.homepage     = "https://github.com/gangstarmn/GSJSONParser"
  s.license      = "MIT"
  s.author             = { "Gantulga" => "gangstarmn@gmail.com" }
  s.ios.deployment_target = '10.0'
  s.watchos.deployment_target = '5.0'
  s.source = { :git => 'https://github.com/gangstarmn/GSJSONParser.git', :tag => "#{s.version}" }

  s.source_files = "GSJSONParser/**/*.{h,m}"

  s.framework = 'UIKit'
  s.requires_arc = true
  s.dependency 'GSLog'

  end

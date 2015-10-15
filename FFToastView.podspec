Pod::Spec.new do |spec|
spec.name         = 'FFToastView'
spec.license      = { :type => 'MIT' }
spec.platform     = :ios, '6.0'
spec.homepage     = 'https://github.com/wujiangwei/FFToastView'
spec.authors      = 'Kevin.Wu'
spec.summary      = 'toast like android'
spec.source       =  {:git => 'https://github.com/wujiangwei/FFToastView.git'}
spec.source_files = 'FFToastView.{h,m}'
spec.frameworks = 'UIKit'
spec.ios.deployment_target = '8.0'
spec.requires_arc = true
end

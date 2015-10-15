Pod::Spec.new do |s|
  s.name     = 'FFToastView'
  s.version  = '1.0'
  s.license  = ':type => 'MIT''
  s.summary  = 'Toast like android'
  s.homepage = 'https://github.com/wujiangwei/FFToastView'
  s.authors  = { Kevin.Wu }
  s.source   = { :git => 'https://github.com/wujiangwei/FFToastView.git' }
  s.source_files = 'FFToastView.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '6.0'
end

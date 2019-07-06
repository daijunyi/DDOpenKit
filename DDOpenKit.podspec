Pod::Spec.new do |s|
  s.name         = "DDOpenKit"
  s.version      = "1.1.6"
  s.summary      = "A ios tool library"
  s.homepage     = "https://github.com/daijunyi/DDOpenKit"
  s.license      = "MIT"
  s.author             = { "“红领巾”" => "“812297736@qq.com”" }
  s.social_media_url   = "https://weibo.com/u/5286053396"
  s.source       = { :git => "https://github.com/daijunyi/DDOpenKit.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.public_header_files = "DDOpenKit/**/*.{h}"
  s.source_files  = "DDOpenKit/**/*.{h,m}"
  s.ios.deployment_target = '8.0'
  s.platform     = :ios, "8.0"
  s.frameworks   = "Foundation"
  s.dependency 'MBProgressHUD'
  s.dependency 'MJRefresh'
  s.dependency 'Masonry'
  s.dependency 'YYCategories'
end

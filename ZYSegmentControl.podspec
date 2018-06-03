Pod::Spec.new do |s|
s.name         = "ZYSegmentControl" # 项目名称
s.version      = "0.0.1"        # 版本号 与 你仓库的 标签号 对应
s.license      = "Apache-2.0"          # 开源证书
s.summary      = "类似于系统的SegmentControl" # 项目简介

s.homepage     = "https://github.com/18734791527/ZYSegmentControl" # 你的主页
s.source       = { :git => "https://github.com/18734791527/ZYSegmentControl.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
s.source_files = "ZYSegmentControl/*.{h,m}" # 你代码的位置， ZYSegmentControl/*.{h,m} 表示 ZYSegmentControl 文件夹下所有的.h和.m文件
s.requires_arc = true # 是否启用ARC
s.platform     = :ios, "7.0" #平台及支持的最低版本
s.frameworks   = "UIKit", "Foundation" #支持的框架
# s.dependency = "" # 依赖库

# User
s.author             = { "BY" => "a18810583594@163.com" } # 作者信息
s.social_media_url   = "https://github.com/18734791527" # 个人主页

end



Pod::Spec.new do |s|
  s.name             = 'Mars-Xlog'
  s.version          = '1.3.0'
  s.summary          = 'Tencent Mars xlog for OC & swift'


  s.description      = <<-DESC
  Tencent MARS only contain xlog, work for OC & swift. No STN etc.
                       DESC

  s.homepage         = 'https://github.com/Tencent/mars'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tanpengsccd' => 'tanpeng@gmail.com' }
  s.source           = { :git => 'https://github.com/tanpengsccd/Mars-Xlog.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '10.0'

  s.source_files = 'MARSDK/Classes/**/*'
# s.public_header_files = 'MARSDK/Classes/**/*.h'
  s.swift_versions = '5'

  ## Mars库配置
  s.vendored_frameworks  = 'MARSDK/Framework/mars.framework'
  s.libraries = 'z','resolv.9'
  s.frameworks = 'CoreTelephony','SystemConfiguration','CoreGraphics'
  s.user_target_xcconfig =   {'OTHER_LDFLAGS' => ['-lc++']}
  
  s.requires_arc = 'MARSDK/Classes/MarsKit/**/*'
#  s.dependency 'Protobuf'
  s.xcconfig = {
      # 'ENABLE_BITCODE' => 'NO' ,
      'VALID_ARCHS' => 'arm64'

#     'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
#     'CLANG_CXX_LIBRARY' => 'libc++'
  }
#  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }


#  s.static_framework = true  #依赖库是静态库也会导致必须此库是静态库

  ## 模块文件
  #s.subspec "MarsKit" do |mk|
  #    mk.source_files = 'MARSDK/Classes/MarsKit/*.{h,m}'
  #end
  
  #s.subspec "ProtoBuffile" do |pb|
  #    pb.source_files = 'MARSDK/Classes/ProtoBuffile/*.{h,m}'
  #end
  
  
  
  
end

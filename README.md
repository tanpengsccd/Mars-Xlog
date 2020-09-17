# MARSDK

[![CI Status](https://img.shields.io/travis/wanghuizhou21@163.com/MARSDK.svg?style=flat)](https://travis-ci.org/wanghuizhou21@163.com/MARSDK)
[![Version](https://img.shields.io/cocoapods/v/MARSDK.svg?style=flat)](https://cocoapods.org/pods/MARSDK)
[![License](https://img.shields.io/cocoapods/l/MARSDK.svg?style=flat)](https://cocoapods.org/pods/MARSDK)
[![Platform](https://img.shields.io/cocoapods/p/MARSDK.svg?style=flat)](https://cocoapods.org/pods/MARSDK)

## Example

OC     使用XLogHelper
```Objective C


//配置
[XLogHelper ConfigXloggerWithPath:@"/xlog"
                  filenamePrefix:@"demo"
                       publicKey:@""
                           level:info //only xlog level >= this level will be append to xlog
                    isConsoleLog:true
];

//打印 （使用宏）
   LOG_INFO(   "TEST", @"%@",@"LOG is Ok!!! this will be show ");
   LOG_DEBUG(  "TEST", @"%@",@"this won't be show"); // because set level to info ,this won't be show


```

swift  使用XLogManager,XLog

```swift

//默认配置
XLogManager.shared.defaultConfig()
/* 或者 定制配置
XLogManager.shared.configXloggerWithPath(path: XLogManager.self.DefaultXlogDir, filenamePrefix: "XLOG", publicKey: "", level: .debug, isConsoleLog: true)
*/
//打印
XLog.Log(level: .info, tag: .track, msg: "这是swift的打印")
//冲刷用于将缓存.map3文件转换为.xlog文件
XLogManager.shared.flush_sync()
//获取所有的日志路径
let logs = XLogManager.shared.allNormalLogs
for log in logs{
    print(log.absoluteString)
}
//关闭 一般是在app 终结是关闭
// XLogManager.shared.close()
```

## Requirements

above  iOS10

## Installation

MARSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Mars-Xlog'
```


## License

MARSDK is available under the MIT license. See the LICENSE file for more info.

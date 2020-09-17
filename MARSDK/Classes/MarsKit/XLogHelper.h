

//#include <stdio.h>
#import <Foundation/Foundation.h>


#define __FILENAME__ (strrchr(__FILE__,'/')+1)

/*
 *  Module Logging ，OC 常用打印
 */
#define LOG_ERROR(module, format, ...) LogInternal(error, module, __FILENAME__, __LINE__, __FUNCTION__, @"Error:", format, ##__VA_ARGS__)
#define LOG_WARNING(module, format, ...) LogInternal(warning, module, __FILENAME__, __LINE__, __FUNCTION__, @"Warning:", format, ##__VA_ARGS__)
#define LOG_INFO(module, format, ...) LogInternal(info, module, __FILENAME__, __LINE__, __FUNCTION__, @"Info:", format, ##__VA_ARGS__)
#define LOG_DEBUG(module, format, ...) LogInternal(debug, module, __FILENAME__, __LINE__, __FUNCTION__, @"Debug:", format, ##__VA_ARGS__)

//判断等级打印
#define LogInternal(level, module, file, line, func, prefix, format, ...) \
do { \
    if ([XLogHelper ShouldLog:level]) { \
        NSString *aMessage = [NSString stringWithFormat:@"%@%@", prefix, [NSString stringWithFormat:format, ##__VA_ARGS__, nil]]; \
        [XLogHelper LogWithLevel:level moduleName:module fileName:file lineNumber:line funcName:func message:aMessage]; \
    } \
} while(0)

///日志等级(其实就是TLoggerLevel，为避免import TLogLevel头文件而污染环境变量)
typedef NS_ENUM(NSUInteger, XLoggerLevel) {
    all = 0,// = kLevelAll,
    verbose = 0 ,// = kLevelVerbose,
    debug ,// = kLevelDebug,
    info ,// = kLevelInfo,
    warning ,// = kLevelWarn,
    error ,// = kLevelError,
    fatal ,// = kLevelFatal,
    none ,// = kLevelNone
};

@interface XLogHelper: NSObject
///直接打印
+ (void)LogWithLevel:(XLoggerLevel)logLevel
          moduleName:(const char*)moduleName
            fileName:(const char*)fileName
          lineNumber:(int)lineNumber
            funcName:(const char*)funcName
             message:(NSString *)message;
///会筛选出应该被打印的等级的日志
+ (void)LogWithLevel:(XLoggerLevel)logLevel
          moduleName:(const char*)moduleName
            fileName:(const char*)fileName
          lineNumber:(int)lineNumber
            funcName:(const char*)funcName
              format:(NSString *)format, ... ;
///该是否应该进入打印
+(BOOL)ShouldLog:(XLoggerLevel)level;

/// 配置
/// @param path 路径
/// @param filenamePrefix 文件前缀
/// @param publicKey 日志加密使用的公钥
/// @param level 会进入打印的日志等级
/// @param isConsoleLog 是否控制台输出打印信息
+(void)ConfigXloggerWithPath: (NSString*)path filenamePrefix: (NSString*)filenamePrefix publicKey:(NSString*)publicKey level:(XLoggerLevel)level isConsoleLog:(BOOL)isConsoleLog;
+(void)Close;
+(void)Flush_sync;

@end



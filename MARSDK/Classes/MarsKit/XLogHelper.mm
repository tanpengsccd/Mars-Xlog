
#import "XLogHelper.h"
#import <mars/xlog/appender.h>
#import <mars/xlog/xlogger.h>
#import <sys/xattr.h>
@implementation XLogHelper : NSObject

// 封装了初始化 Xlogger 方法
+(void)ConfigXloggerWithPath: (NSString*)path filenamePrefix: (NSString*)filenamePrefix publicKey:(NSString*)publicKey level:(XLoggerLevel)level isConsoleLog:(BOOL)isConsoleLog{
    
    NSString* logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:path];
    
    //设置不不同步cloud的路径
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    setxattr([logPath UTF8String], attrName, &attrValue, sizeof(attrValue), 0, 0);
    
    xlogger_SetLevel((TLogLevel)level); //设置打印日志的等级：比如debug 时不打印低于 debug等级的日志
    #if DEBUG
    appender_set_console_log(true);//xcode控制台显示打印
    #else
    appender_set_console_log(false);//xcode控制台显示打印
    #endif
   
    XLogConfig config;
    config.mode_ = kAppednerAsync; //日志添加方式：同步
    config.logdir_ = [logPath UTF8String]; //日志存储路径
    config.nameprefix_ = [filenamePrefix UTF8String]; //日志文件前缀
    config.pub_key_ = [publicKey UTF8String]; ////配置公钥以加密日志
    config.compress_mode_ = kZlib; //压缩方式
    config.compress_level_ = 0; //压缩等级
    config.cachedir_ = ""; //日志缓存文件夹路径
    config.cache_days_ = 0; //缓存时间
    appender_open(config);
    
    

}

///app终结时调用
+(void)Close{
    appender_close();
}
///冲刷(将缓存文件存为xlog文件)
+(void)Flush_sync{
    appender_flush_sync();
}

///打印日志(swift 用)
+(void)LogWithLevel:(XLoggerLevel)type
         moduleName:(const char *)moduleName
           fileName:(const char *)fileName
         lineNumber:(int)lineNumber
           funcName:(const char *)funcName
                msg:(NSString*)msg{
    [self LogWithLevel:type moduleName:moduleName fileName:fileName lineNumber:lineNumber funcName:funcName format: msg];
    
}

///MARK:- Log
static NSUInteger g_processID = 0;
///打印 关键代码
+ (void)LogWithLevel:(XLoggerLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message {
    XLoggerInfo info;
    info.level = (TLogLevel)logLevel; //XloggerType 其实就是TLogLevel
    info.tag = moduleName;
    info.filename = fileName;
    info.func_name = funcName;
    info.line = lineNumber;
    gettimeofday(&info.timeval, NULL);
    info.tid = (uintptr_t)[NSThread currentThread];
    info.maintid = (uintptr_t)[NSThread mainThread];
    info.pid = g_processID;
    xlogger_Write(&info, message.UTF8String);
}

///会筛选出应该被打印的等级的日志
+ (void)LogWithLevel:(XLoggerLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ... {
    if ([self ShouldLog:logLevel]) {
        va_list argList;
        va_start(argList, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
        [self LogWithLevel:logLevel moduleName:moduleName fileName:fileName lineNumber:lineNumber funcName:funcName message:message];
        va_end(argList);
    }
}

+ (BOOL)ShouldLog:(XLoggerLevel)level {
    if ((TLogLevel)level >= xlogger_Level()) {
        return YES;
    }
    return NO;
}

@end



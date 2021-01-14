/*
 pod module 中 由于无法直接extension OC的类，所以只能曲线救国创建新类XLogManager
 OC     使用XLogHelper
 swift  使用XLogManager
 */
import UIKit
//import SwiftyJSON
//import SwiftyUserDefaults

///所有日志的操作（日志，埋点，崩溃）
open class XLogManager {

    public static let shared = XLogManager.init()
    ///崩溃日志文件夹
//    static let crashLogDir      = "/Crash"
    ///xlog日志文件夹
    public static let DefaultXlogDir          = "/Log"
    public required init() {
        self.xlogDir = Self.DefaultXlogDir
    }
    private var xlogDir:String
    ///默认配置
    public func defaultConfig(){
        let isConsoleLog:Bool = {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }()
        configXloggerWithPath(path: XLogManager.self.DefaultXlogDir, filenamePrefix: "XLOG", publicKey: "", level: .debug, isConsoleLog: isConsoleLog)
    }
    ///最近的常规日志(按时间戳升序排列)
    public var allNormalLogs:[URL]{
        let logPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + self.xlogDir
        print(logPath)
        //所有文件
        guard let all = try? FileManager.default.contentsOfDirectory(at: URL(string: logPath)!, includingPropertiesForKeys: nil, options: []) else{

            return []
        }
        //筛选出含WZ 且后缀为xlog的日志文件,升序排列
        let filtered = all.filter { $0.pathExtension == "xlog" }.sorted{$0.lastPathComponent<$1.lastPathComponent}

        return filtered
    }
    

    
    /// 使用前先配置
    /// - Parameters:
    ///   - path: log 存取路径,默认“/Log”
    ///   - filenamePrefix: log文件名前缀
    ///   - publicKey: 日志加密的公钥
    ///   - level: 日志的等级，用于筛选日志
    ///   - isConsoleLog: 是否打印再控制台，一般是调试模式才输出控制台，会额外消耗性能
    public func configXloggerWithPath(path:String, filenamePrefix:String, publicKey:String, level:XLoggerLevel, isConsoleLog:Bool){
        
        XLogHelper.configXlogger(withPath: path, filenamePrefix: filenamePrefix, publicKey: publicKey, level: level, isConsoleLog: isConsoleLog)
        self.xlogDir = path
    }
    ///关闭
    public func close(){
        XLogHelper.close()
    }
    ///冲刷，用于将缓存.map3文件转换为.xlog文件
    public func flush_sync(){
        XLogHelper.flush_sync()
    }
    
}

//MARK: - log
public class XLog{
    ///标签 方便识别
    public enum LogTag{
        ///网络请求
        case net
        ///三方库
        case lib
        ///缓存操作
        case cache
        ///埋点
        case track
        ///崩溃
        case crash
        ///HTML
        case html
        ///其它
        case other(String)
        ///调试
        case debug

        var emojiMark:String{
            //从https://getemoji.com/ 这里找
            switch self{
            case .net:
                return "NETWORKING⚡️"
            case .lib:
                return "⚙️"
            case .other(let o):
                return o
            case .cache:
                return "CACHE🗳"
            case .track:
                return "TRACK🍄"
            case .crash:
                return "CRASH💥"
            case .html:
                return "HTML🌊"
            case .debug:
                return "DEBUG🐛"
            }
        }

    }
    ///打印（为Swift 定制）
    public class func Log(level: XLoggerLevel = .debug, tag:LogTag = .debug , fileName: String = #file, lineNumber: Int = #line, funcName: String = #function , msg: String) {
        XLogHelper.log(with: level, moduleName: tag.emojiMark, fileName: fileName, lineNumber: Int32(lineNumber), funcName: funcName, message: msg)
    }
}


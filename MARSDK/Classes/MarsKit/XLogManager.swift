/*
 pod module 中 由于无法直接extension OC的类，所以只能曲线救国创建新类XLogManager
 OC     使用XLogHelper
 swift  使用XLogManager
 */
import UIKit
//import SwiftyJSON
//import SwiftyUserDefaults

///所有日志的操作（日志，埋点，崩溃）
public class XLogManager {

    public static let shared = XLogManager.init()
    ///崩溃日志文件夹
//    static let crashLogDir      = "/Crash"
    ///xlog日志文件夹
    public static let DefaultXlogDir          = "/Log"
    internal required init() {
        self.xlogDir = Self.DefaultXlogDir
    }
    private var xlogDir:String
    public func configDefault(){
        let isConsoleLog:Bool = {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }()
        configXloggerWithPath(path: XLogManager.self.DefaultXlogDir, filenamePrefix: "WZ", publicKey: "b1e5c081edf37ed8f202c77e67f3521cf1f86ffd831ab37c28c4e53720ca29647cbb0300183f74c2d55159eb6fe3c3783a71022d4fefce146e4ca893a43c4add", level: .debug, isConsoleLog: isConsoleLog)
        // private-key 5e73e342d4c87819d3a2a0013eb61b2267afc4e2ba6a600280a87ddeb14d95f2
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
    //MARK:- copy from

    public func configXloggerWithPath(path:String, filenamePrefix:String, publicKey:String, level:XLoggerLevel, isConsoleLog:Bool){
        
        XLogHelper.configXlogger(withPath: path, filenamePrefix: filenamePrefix, publicKey: publicKey, level: level, isConsoleLog: isConsoleLog)
        self.xlogDir = path
    }
    public func close(){
        XLogHelper.close()
    }
    public func fflush_sync(){
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


/*
//MARK:- networking
extension XLogManager{
    ///上传日志
    class func uploadXLog(willShowLoading:Bool,success: @escaping ((String) -> Void) ,failure:@escaping (SugarNetWorking_Error) -> Void){
        XWLogManager.flush_sync()

        if let log = XLogManager.allNormalLogs.last{
            WZBackendNetWorkingManager.sharedInstance().uploadLogFile(fileKind: .xlog, localFilePath: log, willShowLoading: willShowLoading, success: { res in
                if let address = (res["data"] as? [String:Any])?["address"] as? String {
                    success(address)
                }else{
                    failure(.criterion(code: "", msg: "无address"))
                }
            },failure: failure)
        }
    }
    ///崩溃自动触发上传问题反馈
    class func crashAutoFeedBack(){
        guard !WZBackendNetWorkingManager.shared.service_token.isEmpty else{
            return
        }
        XWLogManager.uploadXLog(willShowLoading: false, success: { (logAddress) in
            let model = Feedback.init()
            model.request_model.contact = "15900000000"
            model.request_model.details = "崩溃自动上报"
            model.request_model.title = "崩溃自动上报"
            model.request_model.logAddress =  logAddress
            
            WZBackendNetWorkingManager.sharedInstance().asyncRequestXWTBackend(req_Model: model,willShowLoading: false, success: {res in
                XWLogManager.Log(level: .info, tag: .net, msg: "崩溃自动上报成功")
                Defaults.isCrashedLastRun = false //标记还原
            },failure: { error in
                XWLogManager.Log(level: .warning, tag: .net, msg: error.errorDescription())
            })
        }, failure: { error in
            XWLogManager.Log(level: .warning, tag: .net, msg: error.errorDescription())
        })
        
    }
}
*/


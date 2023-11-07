//
//  YZNetworkRepository.swift
//  YZNetwork_Swift
//  网络请求仓库

import Foundation
// 网络框架
import Moya
// 响应式编程框架
import RxSwift
// JSON解析框架
import HandyJSON


class YZNetworkRepository {
    static let shared = YZNetworkRepository()

    private var provider: MoyaProvider<YZNetworkAPIService>!
    
    
    func login(_ data: User) -> Observable<YZDetailReponse<YZLoginModel>> {
        return provider
                    .rx
                    .request(.login(data: data))
                    .filterSuccessfulStatusCodes()
                    .mapString()
                    .asObservable()
                    .mapObject(YZDetailReponse<YZLoginModel>.self)

    }
    
    func getAPI() -> Observable<YZListResponse<User>> {
        return provider
            .rx
            .request(.getAPI)
            .asObservable()
            .mapObject(YZListResponse<User>.self)
    }

    
    /// 构造方法私有化，其他文件只能用单例
    private init() {
        var plugin:[PluginType] = []
        if YZNetworkConfig.DEBUG {
            // 调试模式，添加日志插件
            plugin.append(NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)))
        }
        //网络请求加载对话框
        let networkActivityPlugin = NetworkActivityPlugin { change, target in
            //changeType类型是NetworkActivityChangeType
            //通过它能监听到开始请求和结束请求

            //targetType类型是TargetType
            //就是我们这里的service
            //通过它能判断是那个请求
            if change == .began {
                let targetType = target as! YZNetworkAPIService
                switch targetType {
                case .postAPI1, .postAPI2:
                    DispatchQueue.main.async {
                        // 回到主线程 添加 loading
                    }
                default:
                    break
                }
            } else {
                // 请求结束
                DispatchQueue.main.async {
                    // 结束 loading

                }
            }
        }
        plugin.append(networkActivityPlugin)
        
        
        provider = MoyaProvider<YZNetworkAPIService>(plugins:plugin)
    }
}

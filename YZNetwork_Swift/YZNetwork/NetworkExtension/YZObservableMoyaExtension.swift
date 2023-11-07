//
//  YZObservableMoyaExtension.swift
//  YZNetwork_Swift
//  扩展Moya Observable 相关功能

import Foundation
import Moya
import RxSwift
import HandyJSON

/// 自定义错误
///  - objectMapping：表示JSON解析为对象失败
public enum YZNetworkError: Swift.Error {
    case objectMapping
}

// MARK: - 扩展Observable
extension Observable {
    
    /// 将网络请求返回字符串解析为对象
    /// - Parameter type: 要转换为的对象类
    /// - Returns: 转换后的观察者对象
    public func mapObject<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        map { data in
            guard let dataString = data as? String else {
                // data 不能转为字符串
                throw YZNetworkError.objectMapping
            }
            guard let result = type.deserialize(from: dataString) else {
                // 字符串不能转为对象
                throw YZNetworkError.objectMapping
            }
            // 解析成功、返回解析后的对象
            return result
        }
    }
}

// http网络请求观察者
public class YZHttpObserver<Element>: ObserverType {
    // ObserverType协议中用到了泛型E，子类要制定E泛型，不然会报错
    public typealias E = Element
    public typealias successCallback = ((E) -> Void)
    
    // 请求成功回调
    var success: successCallback
    // 请求失败回调
    var error:((YZBaseResponse?, Error?) -> Bool)?
    
    /// 构造方法
    /// - Parameters:
    ///   - success: 请求成功回调
    ///   - error: 请求失败回调
    init(_ success: @escaping successCallback, _ error: ( (YZBaseResponse?, Error?) -> Bool)?) {
        self.success = success
        self.error = error
    }
    
    /// RxSwift框架里发送了事件回调
    /// - Parameter event: <#event description#>
    public func on(_ event: Event<Element>) {
        switch event {
        case .next(let data):
            let baseResponse = data as? YZBaseResponse
            
            if baseResponse?.status != 0 {
                // 状态码不为0，请求出错
                handlerResponse(baseResponse: baseResponse)
            } else {
                // 请求正常
                success(data)
            }
        case .error(let error):
            // 请求失败
            handlerResponse(error: error)
        case .completed:
            // 请求完成
            break
        }
    }
    
    /// 处理错误网络请求
    /// - Parameters:
    ///   - baseResponse: <#baseResponse description#>
    ///   - error: <#error description#>
    func handlerResponse(baseResponse: YZBaseResponse? = nil, error: Error? = nil) {
        if self.error != nil && self.error!(baseResponse, error) {
            // 回调失败
        } else {
            YZExceptionHandleUtil.handlerResponse(baseResponse, error)
        }
    }
    
}


// MARK: - 扩展ObservableType
// 添加两个自定义监听方法
extension ObservableType {
    
    /// 观察成功和失败
    /// - Parameters:
    ///   - success: <#success description#>
    ///   - error: <#error description#>
    /// - Returns: <#description#>
    func subscribe(_ success: @escaping ((Element) -> Void), _ error: @escaping ((YZBaseResponse?, Error?) -> Bool)) -> Disposable {
        // 创建一个Disposable
        let disposable = Disposables.create()
        // 创建YZHttpObserver
        let observer = YZHttpObserver<Element>(success, error)
        // 创建并返回一个Disposables
        return Disposables.create(self.asObservable().subscribe(observer), disposable)
    }
    
    
    /// 观察成功
    /// - Parameter success: <#success description#>
    /// - Returns: <#description#>
    func subscribeSuccess(_ success: @escaping ((Element)-> Void)) -> Disposable {
        let disposable = Disposables.create()
        let observer = YZHttpObserver<Element>(success, nil)
        return Disposables.create(self.asObservable().subscribe(observer), disposable)
    }
    
}

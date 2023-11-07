//
//  YZExceptionHandleUtil.swift
//  YZNetwork_Swift
//
//  Created by 翟鹏程 on 2023/11/7.
//  网络错误处理工具类

import Foundation
import Moya
import Alamofire

class YZExceptionHandleUtil {
    /// 处理网络请求响应
    /// - Parameters:
    ///   - data: <#data description#>
    ///   - error: <#error description#>
    static func handlerResponse(_ data: YZBaseResponse? = nil, _ error: Error? = nil) {
        if error != nil {
            // 网络异常
            handlerError(error!)
        } else {
            if let r = data?.message {
                // 错误提示弹窗？
            } else {
                // 无错误提示弹窗？
            }
        }
    }
    
    /// 处理错误
    /// - Parameter error: <#error description#>
    static func handlerError(_ error: Error) {
        if let error = error as? MoyaError {
            switch error {
            case .stringMapping(_):
                // 响应转字符创错误
                print("响应转字符创错误")
            case .statusCode(let response):
                let code = response.statusCode
                // z
                handlerHttpStatusCodeError(code)
                
            case .underlying(let _ as NSError, _):
                if let alamofireError = error.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError, let underlyingError = alamofireError.underlyingError as? NSError {
                    switch underlyingError.code {
                    case NSURLErrorNotConnectedToInternet:
                        // 没有网络连接
                        print("无网络连接，如网络关闭等")
                    case NSURLErrorTimedOut:
                        // 链接超时
                        print("链接超时，如网络慢等")
                    case NSURLErrorCannotFindHost:
                        // 域名无法解析
                        print("域名无法解析，如写错域名")
                    case NSURLErrorCannotConnectToHost:
                        // 无法连接到主机
                        print("无法连接到主机，如ip地址错误")
                        
                    default:
                        // 未知错误
                        print("未知错误")
                    }
                } else {
                    // 未知错误
                    print("未知错误")
                }
            default:
                // 未知错误
                print("未知错误")
            }
            
        }
    }
    
    
    /// 处理Http StatusCode错误
    /// - Parameter data: <#data description#>
    static func handlerHttpStatusCodeError(_ data: Int) {
        // MARK: 添加业务逻辑
        switch data {
        case 401:
            print(401)
            // 登录信息过期
        case 403:
            // 无访问权限
            print(403)
        case 404:
            // 访问内容不存在
            print(404)
        case 500..<599:
            // 服务器错误
            print(500)
        default:
            // 未知错误
            print(-11)
        }

    }
}



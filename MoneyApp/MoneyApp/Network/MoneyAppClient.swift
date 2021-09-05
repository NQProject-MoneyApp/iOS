//
//  MoneyAppClient.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/08/2021.
//

import Foundation
import Moya

enum MoneyAppApi {

    case login(username: String, password: String)
    case register(username: String, email: String, password: String)
    case groups
    case groupDetails(groupId: Int)
    case joinGroup(code: String)
}

let endpointClosure = { (target: MoneyAppApi) -> Endpoint in
    
    let url = URL(target: target).absoluteString

    return Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
}

private var defaultError: Moya.MoyaError = {
    
    Moya.MoyaError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), nil)
}()

private var lastTimeErrorDate: Date?

func defaultRequest( api: MoneyAppApi, progress: ProgressBlock?, completion: @escaping Completion ) -> Cancellable? {

    let defaultAPIProvider = MoyaProvider<MoneyAppApi>(endpointClosure: endpointClosure, plugins: [CompleteUrlLoggerPlugin()])
    
    return defaultAPIProvider.request(api, callbackQueue: DispatchQueue.main, progress: progress, completion: { result in
        
        if case .success(_) = result {
            lastTimeErrorDate = nil
            
        } else if case let .failure(error) = result {
            
            switch error {
            case .underlying(let nsError as NSError, _):
                
                if nsError.code == -999 {
                    return
                }
            default:
                break
            }
            
            if error._code == NSURLErrorCannotFindHost {
                print("could_not_connect_to_remote")
            } else {
                
                if lastTimeErrorDate == nil || Date().timeIntervalSinceReferenceDate - (lastTimeErrorDate?.timeIntervalSinceReferenceDate ?? 0) > 60 * 1000 {
                    lastTimeErrorDate = Date()
                    print(error.localizedDescription)
                }
            }
        }
        
        completion( result )
    })
}

func defaultRequest( api: MoneyAppApi, completion: @escaping Completion ) -> Cancellable? {
    
    return defaultRequest( api: api, progress: nil, completion: completion )
}

extension MoneyAppApi: TargetType {
    
    var baseURL: URL {
        return URL(string: Config.MoneyAppAPIBaseURL)!
    }
    
    var path: String {
        
        switch self {
        case .login:
            return "/login/"
        case .register:
            return "/registration/"
        case .groups:
            return "/groups/"
        case .groupDetails(let groupId):
            return "/groups/\(groupId)/"
        case .joinGroup(let code):
            return "/join/\(code)/"
        }
    }
    
    var authenticationRequired: Bool {

        switch self {
        case .login:
            return false
        default:
            return true
        }
    }

    var headers: [String: String]? {

        switch self {
        case .login:
            return nil
        default:
            guard let token = Authentication.shared.token() else { return nil }
            return ["Authorization": "Token " + token]
        }
    }
    
    var sampleData: Data {
        
        switch self {
        default: return Data()
        }
    }
    
    var method: Moya.Method {
        
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .groups:
            return .get
        case .groupDetails:
            return .get
        case .joinGroup:
            return .put
        }
    }
   
    var task: Task {
        
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: URLEncoding.default)
        case .register(let username, let email, let password):
            return .requestParameters(parameters: ["username": username, "email": email, "password1": password, "password2": password], encoding: URLEncoding.default)
        case .groups:
            return .requestPlain
        case .groupDetails:
            return .requestPlain
        case .joinGroup:
            return .requestPlain
        }
    }
}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        // uncoment if you woudl like to check url
        print(request.request?.url?.absoluteString ?? "Something is wrong")
    }
}

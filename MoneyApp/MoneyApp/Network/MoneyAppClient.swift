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
    case editGroup(group: Group)
    case fetchUser
    case updateUser(user: User)
    case newExpense(groupId: Int, expense: Expense)
    case editExpense(groupId: Int, expense: Expense)
    case deleteExpense(groupId: Int, expenseId: Int)
    case fetchExpense(groupId: Int, expenseId: Int)
    case code(groupdId: Int)
    case expenses(groupdId: Int)
    case friends
    case addGroup(name: String, icon: Int, members: [Int])
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
        case .editGroup(let group):
            return "/groups/\(group.id)/"
        case .fetchUser:
            return "/user/"
        case .updateUser:
            return "/user/"
        case .newExpense(let groupId, _):
            return "/\(groupId)/expenses/"
        case .editExpense(let groupId, let expense):
            return "/\(groupId)/expenses/\(expense.id)/"
        case .deleteExpense(let groupId, let expenseId):
            return "/\(groupId)/expenses/\(expenseId)/"
        case .fetchExpense(let groupId, let expenseId):
            return "/\(groupId)/expenses/\(expenseId)/"
        case .code:
            return "/group-codes/"
        case .expenses(let groupId):
            return "/\(groupId)/expenses/"
        case .friends:
            return "/friends/"
        case .addGroup:
            return "/groups/"
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
        case .editGroup:
            return .patch
        case .fetchUser:
            return .get
        case .updateUser:
            return .patch
        case .newExpense:
            return .post
        case .editExpense:
            return .put
        case .deleteExpense:
            return .delete
        case .fetchExpense:
            return .get
        case .code:
            return .post
        case .expenses:
            return .get
        case .friends:
            return .get
        case .addGroup:
            return .post
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
        case .editGroup(let group):
            return .requestParameters(parameters: ["is_favourite": group.isFavourite, "name": group.name, "icon": group.icon.rawValue], encoding: URLEncoding.default)
        case .fetchUser:
            return .requestPlain
        case .updateUser(let user):
            return .requestParameters(parameters: ["pk": user.pk, "username": user.name, "email": user.email], encoding: URLEncoding.default)
        case .newExpense(_, let expense):
            return .requestParameters(parameters: [
                "name": expense.name,
                "amount": expense.amount,
                "participants": expense.participants
            ], encoding: JSONEncoding.default)
        case .editExpense(_, let expense):
            return .requestParameters(parameters: [
                "name": expense.name,
                "amount": expense.amount,
                "participants": expense.participants
            ], encoding: JSONEncoding.default)
        case .deleteExpense:
            return .requestPlain
        case .fetchExpense:
            return .requestPlain
        case .code(let groupID):
            return .requestParameters(parameters: ["group": groupID], encoding: URLEncoding.default)
        case .expenses:
            return .requestPlain
        case .friends:
            return .requestPlain
        case .addGroup(let name, let icon, let members):
            return .requestParameters(parameters: [
                "name": name,
                "icon": icon,
                "members": members
            ], encoding: JSONEncoding.default)
        }
    }
}

class CompleteUrlLoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        // uncoment if you woudl like to check url
        print(request.request?.url?.absoluteString ?? "Something is wrong")
    }
}

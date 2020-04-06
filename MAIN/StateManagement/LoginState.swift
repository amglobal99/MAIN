//
//  LoginState.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation
import Cordux

enum LoginAction: Action {
    case isSigningIn(Bool)
    case loginError(UserDisplayError)
}

//extension LoginAction: ActionLogPrintable {
//    var logLevel: ActionLoggingLevel {
//        switch self {
//        default: return .actionDetails
//        }
//    }
//}

//MARK:- LOGIN STATE

struct LoginState {
    var isSigningIn = false
    var username: String?
    var password: String?
}

//MARK:- REDUCER

func loginActionReducer(_ action: LoginAction, state: LoginState) -> LoginState {
    var state = state
    switch action {
    case let .isSigningIn(signingIn):
        state.isSigningIn = signingIn
    case let .loginError(error):
        // Present alert
       print("\(error)")
    }
    return state
}







let invalidCredentialsStatusCode: Int = 403

public enum SimpleResult {
    case success
    case error(Error)
}

public protocol UserDisplayError: Error {
    var messageTitle: String { get }
    var messageBody: String { get }
}

enum Login {
    enum Error: Swift.Error {
        enum System {
            case vpn
            case network(NSError)
            case unknown
            init(error: NSError? = nil) {
                guard let error = error else {
                    self = .unknown
                    return
                }
                self = .network(error)
            }
        }

        enum Server {
            case http(HTTPURLResponse, Data)
            case userUnauthorized
            case unknown
            init(response: HTTPURLResponse? = nil, data: Data? = nil) {
                guard let response = response,
                    let data = data else {
                        self = .unknown
                        return
                }
                self = .http(response, data)
            }

            var isInvalidCredentials: Bool {
                if case let .http(urlResponse, _) = self {
                    return urlResponse.statusCode == invalidCredentialsStatusCode
                }
                return false
            }

        }
    }
}

extension Login.Error.System: UserDisplayError {
    var messageTitle: String {
        switch self {
        case .vpn:
            return "LoginViewController.LoginErrorAlert.NoVPNConnection.Title"
        case .network(let error):
            switch error.code {
            case NSURLErrorTimedOut:
                return "LoginViewController.LoginErrorAlert.TimeoutError.Title"
            default:
                return "GenericError.Title"
            }
        case .unknown:
            return "LoginViewController.LoginErrorAlert.UnknownError.Title"
        }
    }
    
    var messageBody: String {
        switch self {
        case .vpn:
            return "LoginViewController.LoginErrorAlert.NoVPNConnection.Body"
        case .network(let error):
            switch error.code {
            case NSURLErrorTimedOut:
                return "LoginViewController.LoginErrorAlert.TimeoutError.Body"
            default:
                return error.localizedDescription
            }
        case .unknown:
            return "LoginViewController.LoginErrorAlert.UnknownError.Body"
        }
    }
}


extension Login.Error.Server: UserDisplayError {
    var messageTitle: String {
        switch self {
        case .http(let response, _):
            switch response.statusCode {
            case invalidCredentialsStatusCode:
                return "LoginViewController.LoginErrorAlert.InvalidCredentials.Title"
            case 400...499:
                return "LoginViewController.LoginErrorAlert.BadRequest.Title"
            case 500...599:
                return "LoginViewController.LoginErrorAlert.ServerError.Title"
            default:
                return "LoginViewController.LoginErrorAlert.UnknownError.Title"
            }
        case .userUnauthorized:
            return "LoginViewController.LoginErrorAlert.UnauthorizedUser.Title"
        case .unknown:
            return "LoginViewController.LoginErrorAlert.UnknownError.Title"
        }
    }
    
    var messageBody: String {
        switch self {
        case .http(let response, let data):
            switch response.statusCode {
            case invalidCredentialsStatusCode:
                return "LoginViewController.LoginErrorAlert.InvalidCredentials.Body"
            case 400...499:
                return badRequestMessage(data)
            case 500...599:
                return "LoginViewController.LoginErrorAlert.ServerError.Body"
            default:
                return "LoginViewController.LoginErrorAlert.UnknownError.Body"
            }
        case .userUnauthorized:
            return "LoginViewController.LoginErrorAlert.UnauthorizedUser.Body"
        case .unknown:
            return "LoginViewController.LoginErrorAlert.UnknownError.Body"
        }
    }
    
    func badRequestMessage(_ data: Data) -> String {
        do {
            guard let
                responseDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject],
                let serverErrorMessage = responseDict["message"] as? String else {
                    return "LoginViewController.LoginErrorAlert.UnknownError.Body"
            }
            return "LoginViewController.LoginErrorAlert.BadRequest.Body"
        } catch {}
        return "LoginViewController.LoginErrorAlert.UnknownError.Body"
    }
}

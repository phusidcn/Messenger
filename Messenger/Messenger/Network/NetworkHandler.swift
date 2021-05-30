//
//  ResfulAPI.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/8/21.
//

import Foundation

let hostAddress = "115.74.21.169"
let hostPort = 8080

class NetworkHandler: NSObject {

    
    static let sharedNetworkHandler = NetworkHandler()
    var token: String?
    
    func connect(url: URL, completion: ((Data?, URLResponse?, Error?) -> Void)?) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendSignup(with user: UserModel, completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/SignUp"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let signupBody = "{\"Phone\": \"\(user.phoneNumber)\", \"Password\": \"\(user.password!)\", \"Name\": \"\(user.name!)\", \"BDate\":\"\(user.birthDay!)\"}"
        request.httpBody = signupBody.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendLogin(with user: UserModel, completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/Login"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginBody = "{\"Phone\": \"\(user.phoneNumber)\", \"Password\": \"\(user.password!)\"}"
        request.httpBody = loginBody.data(using: .utf8)
        URLSession.shared.dataTask(with: request) {data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendSearch(withSearchEntry text: String, completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/Users"
        urlComponent.queryItems = [URLQueryItem(name: "Phone", value: text)]
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendGetFriendList(completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/FriendShips"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendGetCachedMessage(completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/ketchingMessage"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendAcceptRequest(completion: ((Data?, URLResponse?, Error?) -> ())?) {
        
    }
    
    func sendGetWaitingFriendRequest(completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/ketchingRequestFriend"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendTrackingInfo(_ info: String, completion:((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/trackingBehavior"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.httpBody = info.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendGetBannerRequest(completion:((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/recommend"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) {data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendUserDismissBanner(completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/recommend"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        guard let id = CoreContext.shareCoreContext.bannerId else { return }
        request.httpBody = "{\"id\":\"\(id)\"}".data(using: .utf8)
        URLSession.shared.dataTask(with: request) {data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendLogout(completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        urlComponent.path = "/recommend"
        guard let url = urlComponent.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request).resume()
    }
    
    func getToken() -> String? {
        return self.token
    }
}

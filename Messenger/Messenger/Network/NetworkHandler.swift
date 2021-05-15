//
//  ResfulAPI.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/8/21.
//

import Foundation

let hostAddress = "192.168.1.127"
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
        var urlComponent = URLComponents(string: "http://fgoo.com")
        urlComponent?.scheme = "http"
        urlComponent?.host = hostAddress
        urlComponent?.port = hostPort
        urlComponent?.path = "/SignUp"
        guard let url = urlComponent?.url else {
            print("failed url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let signupBody = "{\"Phone\": \"\(user.phoneNumber)\", \"Password\": \"\(user.password)\", \"Name\": \"\(user.name)\"}"
        request.httpBody = signupBody.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func sendLogin(with user: UserModel, completion: ((Data?, URLResponse?, Error?) -> ())?) {
        var urlComponent = URLComponents(string: "https://as.com")
        urlComponent?.scheme = "http"
        urlComponent?.host = hostAddress
        urlComponent?.port = hostPort
        urlComponent?.path = "/Login"
        guard let url = urlComponent?.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginBody = "{\"Phone\": \"\(user.phoneNumber)\", \"Password\": \"\(user.password)\"}"
        request.httpBody = loginBody.data(using: .utf8)
        URLSession.shared.dataTask(with: request) {data, response, error in
            completion?(data, response, error)
        }.resume()
    }
    
    func getToken() {
        
    }
}

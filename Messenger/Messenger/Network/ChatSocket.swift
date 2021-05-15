//
//  ChatSocket.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/8/21.
//

import Foundation
import Starscream

protocol ChatSocketDelegate {
    
}

class ChatSocket: NSObject {
    
    var socket: WebSocket?
    var delegate: ChatSocketDelegate?
    static let sharedChatSocket = ChatSocket()
    
    func connect() {
        var urlComponent = URLComponents(string: "http://192.168.0.129:8080")
        urlComponent?.scheme = "http"
        urlComponent?.host = hostAddress
        urlComponent?.port = hostPort
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        urlComponent?.queryItems = [URLQueryItem(name: "token", value: token)]
        guard let url = urlComponent?.url else { return }
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket?.delegate = self
        self.socket?.connect()
    }
    
    func disconnect() {
        self.socket?.disconnect()
    }
    
    func sendMessage(data: Data, withCompletion completion: (() -> ())?) {
        socket?.write(data: data, completion: completion)
    }
    
    func sendMessage(string: String, withCompletion completion: (() -> ())?) {
        socket?.write(string: string, completion: completion)
    }
    
    func sendFriendshipRequest() {
        
    }

}

extension ChatSocket: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .binary(let data):
            print("socket: received data \(data)")
        case .text(let text):
            print("socket: received text \(text)")
        case .connected(let header):
            print(header)
        case .disconnected(let reason, let code):
            print("socket: \(reason) - \(code)")
        case .cancelled:
            print("socket: cancel")
        case .error(let error):
            print("socket error: \(error)")
        case .ping(let data):
            print("socket: \(data)")
        case .pong(let data):
            print("socket: \(data)")
        case .viabilityChanged(let changed):
            print("socket viability change: \(changed)")
        case .reconnectSuggested(let needReconnect):
            print("socket: \(needReconnect)")
        default:
            
            print("Other event received")
        }
    }
}

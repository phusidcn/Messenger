//
//  ChatSocket.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/8/21.
//

import Foundation
import Starscream
import SwiftyJSON

protocol ChatSocketMessageDelegate {
    func receivedMessage(text: String, from userId: String)
}

protocol FriendSocketDelegate {
    func receivedFriendRequestResponse(text: String)
}

class ChatSocket: NSObject {
    
    var socket: WebSocket?
    var messengerDelegate: ChatSocketMessageDelegate?
    var friendDelegate: FriendSocketDelegate?
    static let sharedChatSocket = ChatSocket()
    
    func connect() {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = hostAddress
        urlComponent.port = hostPort
        guard let token = NetworkHandler.sharedNetworkHandler.token else { return }
        urlComponent.queryItems = [URLQueryItem(name: "token", value: token)]
        guard let url = urlComponent.url else { return }
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
    
    func sendMessage(string: String, to userModel: UserModel, withCompletion completion: (() -> ())?) {
        let sendData = "{\"\(userModel.id)\":{\"code\": 202, \"message\": \"\(string)\"}}"
        socket?.write(string: sendData, completion: completion)
    }
    
    func sendFriendshipRequest(to userId: String, greetingMessage message: String) {
        let requestContent = "{\"\(userId)\":{\"code\":204, \"message\": \"\(message)\"}}"
        socket?.write(string: requestContent, completion: nil)
    }
    
    func handleReceivedMessage(text: String) {
        print(text)
        let json = JSON(parseJSON: text)
        if let messageType = json["code"].int {
            switch messageType {
            case 205:
                let senderId = json["Id"].string //Dafuq
            case 203:
                let senderId = json["senderId"].string
            case 202:
                guard let senderId = json["senderID"].string else { return }
                guard let messageContent = json["message"].string else { return }
                self.messengerDelegate?.receivedMessage(text: messageContent, from: senderId)
            default:
                print("Bug")
            }
        } else {
            
        }
    }
}

extension ChatSocket: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .binary(let data):
            handleReceivedMessage(text: String(data: data, encoding: .utf8)!)
        case .text(let text):
            handleReceivedMessage(text: text)
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

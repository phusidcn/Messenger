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
    func receivedMessage(message: MessageModel)
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
    
    func sendMessage(message: MessageModel, to userModel: UserModel, withCompletion completion: (() -> ())?) {
        let sendData = "{\"\(userModel.id)\":{\"code\": 202, \"message\": \"\(message.text)\", \"ts\": \"\(message.id)\"}}"
        socket?.write(string: sendData, completion: completion)
    }
    
    func sendFriendshipRequest(to userId: String, greetingMessage message: String) {
        let requestContent = "{\"\(userId)\":{\"code\":204, \"message\": \"\(message)\"}}"
        socket?.write(string: requestContent, completion: nil)
    }
    
    func sendFriendshipResponse(to userId: String) {
        let requestContent = ""
        socket?.write(string: requestContent, completion: nil)
    }
    
    func handleReceivedMessage(text: String) {
        print(text)
        let json = JSON(parseJSON: text)
        guard let received = json.dictionary, let senderId = received.keys.first, let content = received.values.first else { return }
        guard let code = content["code"].int, code == 202 else { return }
        guard let text = content["message"].string else { return }
        guard let ts = content["ts"].string else { return }
        let messageModel = MessageModel(id: ts, sendByID: senderId, receivedID: CoreContext.shareCoreContext.userId, createdAt: Date(timeIntervalSince1970: TimeInterval(ts)!), text: text)
        CoreDataHandler.shareCoreDataHandler.saveMessage(messageModel: messageModel)
        self.messengerDelegate?.receivedMessage(message: messageModel)
        
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

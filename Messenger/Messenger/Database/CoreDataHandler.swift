//
//  CoreDataHandler.swift
//  Messenger
//
//  Created by Huynh Lam Phu Si on 5/9/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler: NSObject {
    
    static let shareCoreDataHandler = CoreDataHandler()
    var offlineMessage: [MessageModel] = []
    
    func getOfflineFriend() {
        
    }
    
    func getThreadChatData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Message")
        do {
            let allMessage = try managedContext.fetch(fetchRequest)
            for message in allMessage {
                let senderId = message.value(forKey: "sender_id") as! String
                let receiverId = message.value(forKey: "receiver_id") as! String
                let content = message.value(forKey: "content") as! String
                let messageId = message.value(forKey: "id") as! String
                let date = message.value(forKey: "date") as! String
                let messageModel = MessageModel(id: messageId, sendByID: senderId, receivedID: receiverId, createdAt: Date(timeIntervalSince1970: TimeInterval(date)!), text: content)
                offlineMessage.append(messageModel)
            }
        } catch let error {
            print("Cannot fetch: \(error.localizedDescription)")
        }
    }
    
    func saveMessage(messageModel: MessageModel) {
        offlineMessage.append(messageModel)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext) else { return }
        let message = NSManagedObject(entity: entity, insertInto: managedContext)
        message.setValue(messageModel.id, forKey: "id")
        message.setValue(messageModel.createdAt, forKey: "date")
        message.setValue(messageModel.sendByID, forKey: "sender_id")
        message.setValue(messageModel.receivedID, forKey: "receiver_id")
        message.setValue(messageModel.text, forKey: "content")
        do {
            try managedContext.save()
        } catch let error {
            print("Cannot save: \(error.localizedDescription)")
        }
    }
    
    func getMessage(ofUser user: UserModel) -> [MessageModel] {
        var results: [MessageModel] = []
        for message in offlineMessage {
            if message.sendByID == user.id || message.receivedID == user.id {
                results.append(message)
            }
        }
        return results
    }
}

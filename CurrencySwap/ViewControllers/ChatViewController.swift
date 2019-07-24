////
////  ChatViewController.swift
////  CurrencySwap
////
////  Created by Admin on 2019-07-05.
////  Copyright © 2019 Test. All rights reserved.
////
//
//import UIKit
//
//class ChatViewController: UIViewController {
//
////    private var messages: [Message] = []
//    private var messageListener: ListenerRegistration?
//    private let db = Firestore.firestore()
//    private var reference: CollectionReference?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        messageInputBar.delegate = self
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//        
//        guard let id = channel.id else {
//            navigationController?.popViewController(animated: true)
//            return
//        }
//        
//        reference = db.collection(["channels", id, "thread"].joined(separator: "/"))
//        
//        
//        messageListener = reference?.addSnapshotListener { querySnapshot, error in
//            guard let snapshot = querySnapshot else {
//                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
//                return
//            }
//            
//            snapshot.documentChanges.forEach { change in
//                self.handleDocumentChange(change)
//            }
//        }
//
//
//
//        // Do any additional setup after loading the view.
//    }
//    
//    private func insertNewMessage(_ message: Message) {
//        guard !messages.contains(message) else {
//            return
//        }
//        
//        messages.append(message)
//        messages.sort()
//        
//        let isLatestMessage = messages.index(of: message) == (messages.count - 1)
//        let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
//        
//        messagesCollectionView.reloadData()
//        
//        if shouldScrollToBottom {
//            DispatchQueue.main.async {
//                self.messagesCollectionView.scrollToBottom(animated: true)
//            }
//        }
//    }
//    
//    private func handleDocumentChange(_ change: DocumentChange) {
//        guard let message = Message(document: change.document) else {
//            return
//        }
//        
//        switch change.type {
//        case .added:
//            insertNewMessage(message)
//            
//        default:
//            break
//        }
//    }
//    
//
//   
////    override func viewDidAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
////
////        let testMessage = Message(user: user, content: "I love pizza, what is your favorite kind?")
////        insertNewMessage(testMessage)
////    }
//
//}
//
//extension ChatViewController: MessagesDataSource {
//    
//    // 1
//    func currentSender() -> Sender {
//        return Sender(id: user.uid, displayName: AppSettings.displayName)
//    }
//    
//    // 2
//    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
//        return messages.count
//    }
//    
//    // 3
//    func messageForItem(at indexPath: IndexPath,
//                        in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        
//        return messages[indexPath.section]
//    }
//    
//    // 4
//    func cellTopLabelAttributedText(for message: MessageType,
//                                    at indexPath: IndexPath) -> NSAttributedString? {
//        
//        let name = message.sender.displayName
//        return NSAttributedString(
//            string: name,
//            attributes: [
//                .font: UIFont.preferredFont(forTextStyle: .caption1),
//                .foregroundColor: UIColor(white: 0.3, alpha: 1)
//            ]
//        )
//    }
//}
//
//extension ChatViewController: MessagesLayoutDelegate {
//    
//    func avatarSize(for message: MessageType, at indexPath: IndexPath,
//                    in messagesCollectionView: MessagesCollectionView) -> CGSize {
//        
//        // 1
//        return .zero
//    }
//    
//    func footerViewSize(for message: MessageType, at indexPath: IndexPath,
//                        in messagesCollectionView: MessagesCollectionView) -> CGSize {
//        
//        // 2
//        return CGSize(width: 0, height: 8)
//    }
//    
//    func heightForLocation(message: MessageType, at indexPath: IndexPath,
//                           with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        
//        // 3
//        return 0
//    }
//}
//
//extension ChatViewController: MessagesDisplayDelegate {
//    
//    func backgroundColor(for message: MessageType, at indexPath: IndexPath,
//                         in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        
//        // 1
//        return isFromCurrentSender(message: message) ? .primary : .incomingMessage
//    }
//    
//    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
//                             in messagesCollectionView: MessagesCollectionView) -> Bool {
//        
//        // 2
//        return true
//    }
//    
//    func messageStyle(for message: MessageType, at indexPath: IndexPath,
//                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
//        
//        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
//        
//        // 3
//        return .bubbleTail(corner, .curved)
//    }
//}
//

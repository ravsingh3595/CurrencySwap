//
//  HomeViewController.swift
//  CurrencySwap
//
//  Created by Admin on 2019-07-03.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    var user: User!
    var postData: [Post] = []
    
//    let postRef = Database.database().reference(withPath: "allPost")
    let usersRef = Database.database().reference(withPath: "online")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        let postRef = Database.database().reference()
//        postRef.child("allPost").observe
        
//        let user = Auth.auth().currentUser!
//        ref.queryOrdered(byChild: user.email!).observe(.value, with: { snapshot in
//            var newItems: [Post] = []
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                    let post = Post(snapshot: snapshot) {
//                    newItems.append(post)
//                }
//            }
//
//            self.postData = newItems
//            self.homeTableView.reloadData()
//        })
    }
        // Do any additional setup after loading the view.
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = homeTableView.dequeueReusableCell(withIdentifier: "homeTableCell") as! UITableViewCell
        let data = postData[indexPath.row]
        article.textLabel?.text = data.myCurrency
        return article
    }
    

    @IBAction func signoutButtonPressed(_ sender: UIBarButtonItem) {
        let user = Auth.auth().currentUser!
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        onlineRef.removeValue { (error, _) in
            if let error = error {
                print("Removing online failed: \(error)")
                return
            }
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
    }
   
}

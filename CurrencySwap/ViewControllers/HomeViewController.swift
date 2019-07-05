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
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    var user: User!
    var postData: [Post] = []
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for:  UIControl.Event.valueChanged)
//        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        self.homeTableView.addSubview(refreshControl) // not required when using UITableViewController
        
//        ref = Database.database().reference()
//        databaseHandle = ref?.child("allPost").observe(.childAdded, with: { (snapshot) in
//            let post = snapshot.value as? [String: AnyObject] ?? [:]
//
//            for value in Array(post.values) {
//
//                let finalValue = value["post"] as? [String: AnyObject] ?? [:]
//                print(finalValue)
//                    self.postData.append(Post(dictionary: finalValue as? [String : AnyObject] ?? [:]))
//                    self.homeTableView.reloadData()
//                }
//            })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.postData = []
        self.homeTableView.reloadData()
        ref = Database.database().reference()
        databaseHandle = ref?.child("allPost").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? [String: AnyObject] ?? [:]
            for value in Array(post.values) {
                let finalValue = value["post"] as? [String: AnyObject] ?? [:]
                self.postData.append(Post(dictionary: finalValue as? [String : AnyObject] ?? [:]))
                self.homeTableView.reloadData()
            }
        })
    }
    
    
   
    @objc func refresh(sender:AnyObject) {
//        print("InitialValue :\(postData) \n")
        self.postData = []
        ref = Database.database().reference()
        databaseHandle = ref?.child("allPost").observe(.childAdded, with: { (snapshot) in
            
            let post = snapshot.value as? [String: AnyObject] ?? [:]
            for value in Array(post.values) {
                let finalValue = value["post"] as? [String: AnyObject] ?? [:]
                print("finalValue :\(finalValue) \n")
                    self.postData.append(Post(dictionary: finalValue))
                
                    self.homeTableView.reloadData()
                
               
            }
        })
        
        self.homeTableView.reloadData()
        refreshControl.endRefreshing()
    }
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = homeTableView.dequeueReusableCell(withIdentifier: "homeTableCell") as! UITableViewCell
        let data = postData[indexPath.row]
        article.textLabel?.text = "Offering $\(data.myAmount ?? "") \(data.myCurrency ?? "") in Exchange from \(data.yourCurrency ?? "") in \(data.yourAmount ?? "")"
        article.textLabel?.numberOfLines = 2
        return article
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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

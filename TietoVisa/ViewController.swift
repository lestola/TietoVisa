//
//  ViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 9.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameButton: UIBarButtonItem!
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    
    var postData = [String]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let x = UserDefaults.standard.object(forKey: "savedEmail") as? String
         {
         usernameButton.title = x
         
         }

        
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //set the firebase reference
        ref =  FIRDatabase.database().reference()
        
        
        //retrieve the post and listen for changes
        //alkuperäinen
        //databaseHandle = ref?.child("Kysymykset").child("Elokuvat").child("kysymys1").observe(.childAdded, with: { (snapshot) in
            
        databaseHandle = ref?.child("/Kysymykset/Elokuvat/").observe(.value, with: { (snapshot) in
            
            /*firebase.database().ref('/data/?shallow=true').once('value', function(snapshot) {
                // do something with snapshot
            }*/
            
            // code to execute when a child is added under "posts"
            // take the value frmom the snapshot and added it to the post data array
            //alkuperäinen
            //let post = snapshot.value as? String
            let post = snapshot.key as? String
            
            if let actualPost = post {
                
            self.postData.append(actualPost)
                
            self.tableView.reloadData()
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }

}


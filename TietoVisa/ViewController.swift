//
//  ViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 9.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameButton: UIBarButtonItem!
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    let user = FIRAuth.auth()?.currentUser
    
    
    var postData = [String]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TÄLLÄ SAA NÄKYMÄÄN EMAIL OSOITTEEN YLÄKULMASSA
        /*if let x = UserDefaults.standard.object(forKey: "savedEmail") as? String
         {
         usernameButton.title = x
         
         }*/
        
        //TÄLLÄ SAA NÄKYMÄÄN UID:N YLÄKULMASSA
        
        usernameButton.title = user?.uid
        
        
        
        

        
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //set the firebase reference
        ref =  FIRDatabase.database().reference()
        
        
        //retrieve the post and listen for changes
        //alkuperäinen
        //databaseHandle = ref?.child("Kysymykset").child("Elokuvat").child("kysymys1").observe(.childAdded, with: { (snapshot) in
        
        /*
         databaseHandle = ref?.child("posts").observe(.childAdded, with: { (snapshot) in
         
         //kun lapsi lisätään posteihin
         //ota arvo snapshotista ja laita se postDatataan
         let post = snapshot.value as? String
         
         if let actualPost = post {
         
         //laita postidata sinne minnekuuluu eli post data arrayhin
         self.postData.append(actualPost)
         
         //päivitä teblevievin sisältö
         self.tableView.reloadData()
         }
 */
        
        databaseHandle = ref?.child("UserData").child((user?.uid)!).child("Games").observe(.childAdded, with: { (snapshot) in
            
            ///kun lapsi lisätään posteihin
            //ota arvo snapshotista ja laita se postDatataan
            let post = snapshot.value as? String
            
            if let actualPost = post {
                
                //laita postidata sinne minnekuuluu eli post data arrayhin
                self.postData.append(actualPost)
                
                //päivitä teblevievin sisältö
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


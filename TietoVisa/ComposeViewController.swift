//
//  ComposeViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 13.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref:FIRDatabaseReference?
    
        override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addPost(_ sender: Any) {
        //post data to firebase
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        
        
        //dismiss the pop over
        presentingViewController?.dismiss(animated: true, completion: nil)
    }


    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

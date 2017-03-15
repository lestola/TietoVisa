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
    @IBOutlet weak var kysymysTextField: UITextField!
    @IBOutlet weak var oikeaVastausTextField: UITextField!
    @IBOutlet weak var vaaraVastaus1TextField: UITextField!
    @IBOutlet weak var vaaraVastaus2TextField: UITextField!
    @IBOutlet weak var vaaraVastaus3TextField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var verifyedLabel: UILabel!
    
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
        //lisätään kysymys tietokantaan
        let key = ref?.child("Kysymykset").child("Elokuvat").childByAutoId().key
        let post = ["question": kysymysTextField.text,
                    "answer1": oikeaVastausTextField.text,
                    "answer2": vaaraVastaus1TextField.text,
                    "answer3": vaaraVastaus2TextField.text,
                    "answer4": vaaraVastaus3TextField.text,
                    "addedby": userLabel.text,
                    "verifyed": verifyedLabel.text]
        let childUpdates = ["/Kysymykset/Elokuvat/\(key)": post]
        ref?.updateChildValues(childUpdates)
        
        //dismiss the pop over
        presentingViewController?.dismiss(animated: true, completion: nil)
    }


    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

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
    
    var newSequenceNumber:Int = 0
    
    var ref:FIRDatabaseReference?
    
        override func viewDidLoad() {
            
            
        super.viewDidLoad()
        
            //yhdistetään tietokantaan tekemällä ref
        ref = FIRDatabase.database().reference()
            
        //haetaan kysymysten määrä teitokannasta
        getNumberOfQuestions()
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getNumberOfQuestions() {
        
        //haetaan kysymyksen numero tietokannasta ja asetetaan se muuttujaan newSequenceNumber
        ref?.child("Kysymykset").child("Elokuvat").child("Data").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let countOfQuestions = value?["Count"] as! Int
            
            self.newSequenceNumber = countOfQuestions
            print("tämä asetetaan getnumeberissa:")
            print(self.newSequenceNumber)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

        
    }
    
    @IBAction func addPost(_ sender: Any) {
        
        //lisätään kysymys tietokantaan
        print("tämä ptäisi mennä tietokantaan:")
        print(self.newSequenceNumber)
        
        //lisätään countterin muuttujaan yksi
        self.newSequenceNumber += 1
        let key = ref?.child("Kysymykset").child("Elokuvat").child(String(newSequenceNumber)).key
        let post = ["question": kysymysTextField.text,
                    "answer1": oikeaVastausTextField.text,
                    "answer2": vaaraVastaus1TextField.text,
                    "answer3": vaaraVastaus2TextField.text,
                    "answer4": vaaraVastaus3TextField.text,
                    "addedby": userLabel.text,
                    "verifyed": verifyedLabel.text]
        let childUpdates = ["/Kysymykset/Elokuvat/\(key)": post]
        ref?.updateChildValues(childUpdates)
        
        //lisätään myös countterin tietokanta arvoon 1 jotta kysymysten määrä mätsää!!
        
        self.ref?.child("Kysymykset").child("Elokuvat").child("Data").setValue(["Count": self.newSequenceNumber])
        
        
        //dismiss the pop over
        presentingViewController?.dismiss(animated: true, completion: nil)
    }


    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

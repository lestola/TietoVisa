//
//  ComposeViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 13.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var kysymysTextField: UITextField!
    @IBOutlet weak var oikeaVastausTextField: UITextField!
    @IBOutlet weak var vaaraVastaus1TextField: UITextField!
    @IBOutlet weak var vaaraVastaus2TextField: UITextField!
    @IBOutlet weak var vaaraVastaus3TextField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var verifyedLabel: UILabel!
    @IBOutlet weak var Picker1: UIPickerView!
    
    var newSequenceNumber:Int = 0
    
    var Array = ["jaakko","Elokuvat","marko"]
    
    var ref:FIRDatabaseReference?
    
    var valittuKategoria:String = ""
    
    
        override func viewDidLoad() {
            
            
        super.viewDidLoad()
        
            //yhdistetään tietokantaan tekemällä ref
        ref = FIRDatabase.database().reference()
            
        //haetaan kysymysten määrä teitokannasta
        getNumberOfQuestions()
            
        //pickerView dataSourcen ja delegaten määrittely, lähteenä itsensä
        Picker1.delegate = self
        Picker1.dataSource = self
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
        let key = ref?.child("Kysymykset").child(valittuKategoria).child(String(newSequenceNumber)).key
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valittuKategoria = Array[row]
        
    }
}

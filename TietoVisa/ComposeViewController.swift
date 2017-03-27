//
//  ComposeViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 13.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ComposeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var kysymysTextField: UITextField!
    @IBOutlet weak var oikeaVastausTextField: UITextField!
    @IBOutlet weak var vaaraVastaus1TextField: UITextField!
    @IBOutlet weak var vaaraVastaus2TextField: UITextField!
    @IBOutlet weak var vaaraVastaus3TextField: UITextField!
    @IBOutlet weak var verifyedLabel: UILabel!
    @IBOutlet weak var Picker1: UIPickerView!
    
    var newSequenceNumber:Int = 0
    var Array = ["Avaruus", "Elokuvat","Historia","Maantiede","Ruoka","Tiede","Tekniikka","Tietotekniikka","TV-Ohjelmat"]
    var ref:FIRDatabaseReference?
    let user = FIRAuth.auth()?.currentUser
    var valittuKategoria:String = ""
    
    
        override func viewDidLoad() {
            
            
        super.viewDidLoad()
        //yhdistetään tietokantaan tekemällä ref
        ref = FIRDatabase.database().reference()
            
            
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
        ref?.child("Kysymykset").child(valittuKategoria).child("Data").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            var countOfQuestions = value?["Count"] as! Int
    
            print("tämä oli tietokannassa getnumeberissa:")
            print(countOfQuestions)
            
            countOfQuestions += 1
            print("tämä asetetaan getnumberissa:")
            print(self.newSequenceNumber)
            
            self.writeToDatabase(sequenceNumber: countOfQuestions)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        //kirjoitetaan tiedot tietokantaan
        
        
    }
    
    func writeToDatabase(sequenceNumber:Int){
        
        //lisätään kysymys tietokantaan
        print("tämä ptäisi mennä tietokantaan:")
        print(sequenceNumber)
        
        //määritellään le post...
        let post = ["question": kysymysTextField.text,
                    "answer1": oikeaVastausTextField.text,
                    "answer2": vaaraVastaus1TextField.text,
                    "answer3": vaaraVastaus2TextField.text,
                    "answer4": vaaraVastaus3TextField.text,
                    "addedby": user?.uid,
                    "unverifyed": verifyedLabel.text,
                    "reported" : verifyedLabel.text]
        
        let childUpdates = ["/Kysymykset/\(valittuKategoria)/\(sequenceNumber)": post]
        ref?.updateChildValues(childUpdates)
 
        //lisätään myös countterin tietokanta arvoon 1 jotta kysymysten määrä mätsää!!
 
        self.ref?.child("Kysymykset").child(valittuKategoria).child("Data").setValue(["Count": sequenceNumber])
        
    }
    
    @IBAction func addPost(_ sender: Any) {
        
        //haetaan kysymysten määrä teitokannasta
        getNumberOfQuestions()
        
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        //Dismiss the keyboard when teh view is tapped on
        kysymysTextField.resignFirstResponder()
        oikeaVastausTextField.resignFirstResponder()
        vaaraVastaus1TextField.resignFirstResponder()
        vaaraVastaus2TextField.resignFirstResponder()
        vaaraVastaus3TextField.resignFirstResponder()
        
    }

}

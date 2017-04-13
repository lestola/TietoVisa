//
//  CategoryViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 13.4.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CategoryViewController: UIViewController {

    var numberOfCategoryToChoose = Int()
    var gameNumber:String = ""
    var ref:FIRDatabaseReference?
    var categoryName:String = ""
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var infoTextLabel: UILabel!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //yhdistetään tietokantaan
        ref = FIRDatabase.database().reference()
        
        //laitetaan tietoa näytölle monesko kategoria valitaan
        infoTextLabel.text = "Valitse " + String(numberOfCategoryToChoose) + ".  aihe kysymyksille!"
        
        //haetaan paikallisesta tietokannasta pelinumero
        if let geimi = UserDefaults.standard.object(forKey: "currentGameSaved") as? String{
            gameNumber = geimi
            
        }
        
        //arvotaan nappien nimet!
        getButtonNames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getButtonNames(){
        //arvotaan kategoria ja valitaan sen muuttujaan
        ref?.child("Data").child("Kategoriat").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let countOfCategories = value?["Count"] as! Int
            //kirjoitetaan kategoranimi ensimmäiseen appulaan
            let randomCategory = arc4random_uniform(UInt32(countOfCategories))
            self.categoryName = value?[String(randomCategory)] as? String ?? ""
            self.firstButton.setTitle(self.categoryName, for: .init())
            //kirjoitetaan kategorianimi toiseen nappulaan
            let randomCategory2 = arc4random_uniform(UInt32(countOfCategories))
            self.categoryName = value?[String(randomCategory2)] as? String ?? ""
            self.secondButton.setTitle(self.categoryName, for: .init())
            //kirjoitetaan kategorianimi kolmanteen nappulaan
            let randomCategory3 = arc4random_uniform(UInt32(countOfCategories))
            self.categoryName = value?[String(randomCategory3)] as? String ?? ""
            self.thirdButton.setTitle(self.categoryName, for: .init())
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func firstButtonAction(_ sender: UIButton) {
        let dataBaseHandle = self.ref?.child("Games").child(gameNumber)
        let button = firstButton.currentTitle
        
        if numberOfCategoryToChoose == 1{
            dataBaseHandle?.child("topic1").setValue(button)
        }
        if numberOfCategoryToChoose == 2{
            dataBaseHandle?.child("topic2").setValue(button)
        }
        if numberOfCategoryToChoose == 3{
            dataBaseHandle?.child("topic3").setValue(button)
        }
        if numberOfCategoryToChoose == 4{
            dataBaseHandle?.child("topic4").setValue(button)
        }
        if numberOfCategoryToChoose == 5{
            dataBaseHandle?.child("topic5").setValue(button)
        }
        if numberOfCategoryToChoose == 6{
            dataBaseHandle?.child("topic6").setValue(button)
        }
        //siirrytään kysymysten pariin
        performSegue(withIdentifier: "showQuestionSegue", sender: button)
        
    }
    @IBAction func secondButtonAction(_ sender: UIButton) {
        let dataBaseHandle = self.ref?.child("Games").child(gameNumber)
        let button = secondButton.currentTitle
        
        if numberOfCategoryToChoose == 1{
            dataBaseHandle?.child("topic1").setValue(button)
        }
        if numberOfCategoryToChoose == 2{
            dataBaseHandle?.child("topic2").setValue(button)
        }
        if numberOfCategoryToChoose == 3{
            dataBaseHandle?.child("topic3").setValue(button)
        }
        if numberOfCategoryToChoose == 4{
            dataBaseHandle?.child("topic4").setValue(button)
        }
        if numberOfCategoryToChoose == 5{
            dataBaseHandle?.child("topic5").setValue(button)
        }
        if numberOfCategoryToChoose == 6{
            dataBaseHandle?.child("topic6").setValue(button)
        }
        //siirrytään kysymysten pariin
        performSegue(withIdentifier: "showQuestionSegue", sender: button)
    }
    @IBAction func thirdButtonAction(_ sender: UIButton) {
        let dataBaseHandle = self.ref?.child("Games").child(gameNumber)
        let button = thirdButton.currentTitle
        
        if numberOfCategoryToChoose == 1{
            dataBaseHandle?.child("topic1").setValue(button)
        }
        if numberOfCategoryToChoose == 2{
            dataBaseHandle?.child("topic2").setValue(button)
        }
        if numberOfCategoryToChoose == 3{
            dataBaseHandle?.child("topic3").setValue(button)
        }
        if numberOfCategoryToChoose == 4{
            dataBaseHandle?.child("topic4").setValue(button)
        }
        if numberOfCategoryToChoose == 5{
            dataBaseHandle?.child("topic5").setValue(button)
        }
        if numberOfCategoryToChoose == 6{
            dataBaseHandle?.child("topic6").setValue(button)
        }
        //siirrytään kysymysten pariin
        performSegue(withIdentifier: "showQuestionSegue", sender: button)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let guest : ScoreViewController = segue.destination as! ScoreViewController
        //guest.gameNumber = sender as! String
        //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuestionSegue" {
            let controller = segue.destination as! GameScreenViewController
            controller.categoryName = sender as! String
            
        } else if segue.identifier == "addQuestionSegue" {
            //let controller = segue.destination as! ComposeViewController
            //controller.history = self.history
        }
    }

    

}

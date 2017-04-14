//
//  gameScreenViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 16.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//
import UIKit
import FirebaseDatabase

class GameScreenViewController: UIViewController  {

    @IBOutlet weak var kysymysLabel: UILabel!
    @IBOutlet weak var aikaProgressBar: UIProgressView!
    @IBOutlet weak var vastaus1Button: UIButton!
    @IBOutlet weak var vastaus2Button: UIButton!
    @IBOutlet weak var vastaus3Button: UIButton!
    @IBOutlet weak var vastaus4Button: UIButton!
  
    
    //muutama laiton muuttuja
    var Array = [String]()
    var categoryName:String = ""
    var numberOfQuestion:Int = 0
    var ref:FIRDatabaseReference?
    var outOfThree = 0
    var rightAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //yhdistetään tietokantaan
        ref = FIRDatabase.database().reference()
        //lähtään hakemaan kategorian nimeä
        getNumberOfQuestion()
    }
    
    func getNumberOfQuestion(){
        //arvotaan kategoria ja valitaan sen muuttujaan
        ref?.child("Kysymykset").child(self.categoryName).child("Data").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let howManyQuestions = value?["Count"] as! Int
            let randomNumber = arc4random_uniform(UInt32(howManyQuestions)) + 1
            self.numberOfQuestion = Int(randomNumber)
            //siirrytään itse kysymyksen hakuun ja sen saattamiseen ruudulle
            self.lataaKysymysTietokannasta()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
   /* func getNameOfCategory(){
        //arvotaan kategoria ja valitaan sen muuttujaan
        ref?.child("Data").child("Kategoriat").observeSingleEvent(of: .value, with: { (snapshot) in
        
            let value = snapshot.value as? NSDictionary
            let countOfCategories = value?["Count"] as! Int
            let randomCategory = arc4random_uniform(UInt32(countOfCategories))
            self.categoryName = value?[String(randomCategory)] as? String ?? ""
            //siirrytään kysymys numeron hakuun
            self.getNumberOfQuestion()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }*/
    
    func lataaKysymysTietokannasta(){
    //koodi joka lataa kysymyksen tietokanasta, sekä kysymykseen liitetyt väärät, sekä oikean vastauksen nappuloihin
    //TODO: nappuloita pitää sekoittaa.. nyt ensimmäisessä aina oikea vastaus!
        print(self.categoryName)
        print(self.numberOfQuestion)
        ref?.child("Kysymykset").child(self.categoryName).child(String(self.numberOfQuestion)).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let kysymys = value?["question"] as? String ?? ""
            let oikeaVastaus = value?["answer1"] as? String ?? ""
            let vaara1Vastaus = value?["answer2"] as? String ?? ""
            let vaara2Vastaus = value?["answer3"] as? String ?? ""
            let vaara3Vastaus = value?["answer4"] as? String ?? ""
            
            self.rightAnswer = Int(arc4random_uniform(4)) + 1
            
            if self.rightAnswer == 1{
                
                self.kysymysLabel.text = kysymys
                self.vastaus1Button.setTitle(oikeaVastaus, for: .init())
                self.vastaus2Button.setTitle(vaara1Vastaus, for: .init())
                self.vastaus3Button.setTitle(vaara2Vastaus, for: .init())
                self.vastaus4Button.setTitle(vaara3Vastaus, for: .init())
                
            }
            
            if self.rightAnswer == 2{
                
                self.kysymysLabel.text = kysymys
                self.vastaus1Button.setTitle(vaara1Vastaus, for: .init())
                self.vastaus2Button.setTitle(oikeaVastaus, for: .init())
                self.vastaus3Button.setTitle(vaara2Vastaus, for: .init())
                self.vastaus4Button.setTitle(vaara3Vastaus, for: .init())
                
            }
            
            if self.rightAnswer == 3{
                
                self.kysymysLabel.text = kysymys
                self.vastaus1Button.setTitle(vaara1Vastaus, for: .init())
                self.vastaus2Button.setTitle(vaara2Vastaus, for: .init())
                self.vastaus3Button.setTitle(oikeaVastaus, for: .init())
                self.vastaus4Button.setTitle(vaara3Vastaus, for: .init())
                
            }
            
            if self.rightAnswer == 4{
                
                self.kysymysLabel.text = kysymys
                self.vastaus1Button.setTitle(vaara1Vastaus, for: .init())
                self.vastaus2Button.setTitle(vaara2Vastaus, for: .init())
                self.vastaus3Button.setTitle(vaara3Vastaus, for: .init())
                self.vastaus4Button.setTitle(oikeaVastaus, for: .init())
                
            }
            
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
            }
    }
  
    @IBAction func vastaus1ButtonAction(_ sender: UIButton) {
        //Lisätään kysyttyjen kysymysten countteriin yksi
        outOfThree += 1
        //tarkistetaan onko tämä nappula oikea vastaus
        if rightAnswer == 1 {
            vastaus1Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
        }
        else{
            vastaus1Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
        
        
    }
    @IBAction func vastaus2ButtonAction(_ sender: UIButton) {
        outOfThree += 1
        if rightAnswer == 2 {
            vastaus2Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
        }
        else{
            vastaus2Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
    }
    @IBAction func vastaus3ButtonAction(_ sender: UIButton) {
        outOfThree += 1
        if rightAnswer == 3 {
            vastaus3Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
        }
        else{
            vastaus3Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
    }
    @IBAction func vastaus4ButtonAction(_ sender: UIButton) {
        outOfThree += 1
        if rightAnswer == 4 {
            vastaus4Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
        }
        else{
            vastaus4Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
    }
    
}

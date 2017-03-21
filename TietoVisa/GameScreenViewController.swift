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
  
    var ref:FIRDatabaseReference?
    
    var Array = [String]()
    
    var categoryName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
        getNameOfCategory()
        
    }
    
    func getNameOfCategory(){
        //arvotaan kategoria ja valitaan sen muuttujaan
        ref?.child("Data").child("Kategoriat").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            let countOfCategories = value?["Count"] as! Int
            let randomCategory = arc4random_uniform(UInt32(countOfCategories))
            print(randomCategory)
            self.categoryName = value?[String(randomCategory)] as? String ?? ""
            
            print(self.categoryName)
            print(self.categoryName)
            self.lataaKysymysTietokannasta()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    
    }
    
    
    func lataaKysymysTietokannasta(){

    //koodi joka lataa kysymyksen tietokanasta, sekä kysymykseen liitetyt väärät, sekä oikean vastauksen nappuloihin
    //TODO: nappuloita pitää sekoittaa.. nyt ensimmäisessä aina oikea vastaus!
        let numero:Int = 1
        
        print(self.categoryName)
        print(self.categoryName)
        ref?.child("Kysymykset").child(self.categoryName).child(String(numero)).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let kysymys = value?["question"] as? String ?? ""
            let oikeaVastaus = value?["answer1"] as? String ?? ""
            let vaara1Vastaus = value?["answer2"] as? String ?? ""
            let vaara2Vastaus = value?["answer3"] as? String ?? ""
            let vaara3Vastaus = value?["answer4"] as? String ?? ""
            
            self.kysymysLabel.text = kysymys
            self.vastaus1Button.setTitle(oikeaVastaus, for: .init())
            self.vastaus2Button.setTitle(vaara1Vastaus, for: .init())
            self.vastaus3Button.setTitle(vaara2Vastaus, for: .init())
            self.vastaus4Button.setTitle(vaara3Vastaus, for: .init())
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
            }
        
    }
  
    
    @IBAction func vastaus1ButtonAction(_ sender: UIButton) {
    }
    @IBAction func vastaus2ButtonAction(_ sender: UIButton) {
    }
    @IBAction func vastaus3ButtonAction(_ sender: UIButton) {
    }
    @IBAction func vastaus4ButtonAction(_ sender: UIButton) {
    }
    
}

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
    var countOfRightAnswers = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //yhdistetään tietokantaan
        ref = FIRDatabase.database().reference()
        
        //lähtään hakemaan kategorian nimeä
        laskuri()
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
    
    func laskuri(){
        //alustetaan nappulapohjat
        self.vastaus1Button.setBackgroundImage(#imageLiteral(resourceName: "2000px-HILLBLU_button_background"), for: .normal)
        self.vastaus2Button.setBackgroundImage(#imageLiteral(resourceName: "2000px-HILLBLU_button_background"), for: .normal)
        self.vastaus3Button.setBackgroundImage(#imageLiteral(resourceName: "2000px-HILLBLU_button_background"), for: .normal)
        self.vastaus4Button.setBackgroundImage(#imageLiteral(resourceName: "2000px-HILLBLU_button_background"), for: .normal)
        
        //aletaan kyselemään jos kysymyksiä on kysytty alle 3
        if outOfThree < 3{
           getNumberOfQuestion()
        }
        //jos kysymykset on kysytty, niin lisätään tietokantaan monta meni oikein
        else{
            print("valmis")
            if let paska = UserDefaults.standard.object(forKey: "currentGameSaved") as? String{
               let gameNumber = paska
                
                ref?.child("Games").child(gameNumber).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    let roundsPlayed = value?["playedRounds"] as! Int
                    
                    print("rounds played:", roundsPlayed)
                    if roundsPlayed == 0 {
                        self.ref?.child("Games").child(gameNumber).child("round1").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(1)
                    }
                    if roundsPlayed == 1 {
                        self.ref?.child("Games").child(gameNumber).child("round2").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(2)
                    }
                    if roundsPlayed == 2 {
                        self.ref?.child("Games").child(gameNumber).child("round3").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(3)
                    }
                    if roundsPlayed == 3 {
                        self.ref?.child("Games").child(gameNumber).child("round4").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(4)
                    }
                    if roundsPlayed == 4 {
                        self.ref?.child("Games").child(gameNumber).child("round5").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(5)
                    }
                    if roundsPlayed == 5 {
                        self.ref?.child("Games").child(gameNumber).child("round6").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(6)
                    }
                    if roundsPlayed == 6 {
                        self.ref?.child("Games").child(gameNumber).child("round7").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(7)
                    }
                    if roundsPlayed == 7 {
                        self.ref?.child("Games").child(gameNumber).child("round8").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(8)
                    }
                    if roundsPlayed == 8 {
                        self.ref?.child("Games").child(gameNumber).child("round9").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(9)
                    }
                    if roundsPlayed == 9 {
                        self.ref?.child("Games").child(gameNumber).child("round10").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(10)
                    }
                    if roundsPlayed == 10 {
                        self.ref?.child("Games").child(gameNumber).child("round11").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(11)
                    }
                    if roundsPlayed == 11 {
                        self.ref?.child("Games").child(gameNumber).child("round12").setValue(String(self.countOfRightAnswers))
                        self.ref?.child("Games").child(gameNumber).child("playedRounds").setValue(12)
                    }
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
            //tänne segue
            performSegue(withIdentifier: "goToViewController", sender: self)
            
        }
    }
    
    func lataaKysymysTietokannasta(){
    //koodi joka lataa kysymyksen tietokanasta, sekä kysymykseen liitetyt väärät, sekä oikean vastauksen nappuloihin
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
            
            //arvotaan oikean vastauksen paikka
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
  
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    @IBAction func vastaus1ButtonAction(_ sender: UIButton) {
        //Lisätään kysyttyjen kysymysten countteriin yksi
        outOfThree += 1
        //tarkistetaan onko tämä nappula oikea vastaus
        if rightAnswer == 1 {
            vastaus1Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
            self.countOfRightAnswers += 1
        }
        else{
            vastaus1Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
        //viivytellään muutama sekuntti ennenkuin vaihdetaan takaisin normaali iconi
        delayWithSeconds(3) {
            self.laskuri()
        }
        
        
    }
    @IBAction func vastaus2ButtonAction(_ sender: UIButton) {
        outOfThree += 1
        if rightAnswer == 2 {
            vastaus2Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
            self.countOfRightAnswers += 1
        }
        else{
            vastaus2Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
        //viivytellään muutama sekuntti ennenkuin vaihdetaan takaisin normaali iconi
        delayWithSeconds(3) {
            self.laskuri()
        }
        
    }
    @IBAction func vastaus3ButtonAction(_ sender: UIButton) {
        outOfThree += 1
        if rightAnswer == 3 {
            vastaus3Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
            self.countOfRightAnswers += 1
        }
        else{
            vastaus3Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
        //viivytellään muutama sekuntti ennenkuin vaihdetaan takaisin normaali iconi
        delayWithSeconds(3) {
            self.laskuri()
        }
        
    }
    @IBAction func vastaus4ButtonAction(_ sender: UIButton) {
        outOfThree += 1
        if rightAnswer == 4 {
            vastaus4Button.setBackgroundImage(#imageLiteral(resourceName: "yesIcon"), for: .normal)
            self.countOfRightAnswers += 1
        }
        else{
            vastaus4Button.setBackgroundImage(#imageLiteral(resourceName: "noIcon"), for: .normal)
        }
        //viivytellään muutama sekuntti ennenkuin vaihdetaan takaisin normaali iconi
        delayWithSeconds(3) {
            self.laskuri()
        }
        
    }
    
}

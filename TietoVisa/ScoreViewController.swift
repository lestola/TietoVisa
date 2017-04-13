//
//  ScoreViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 27.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ScoreViewController: UIViewController {

    
    @IBOutlet weak var peliNumero: UILabel!
    @IBOutlet weak var round1Button: UIButton!
    @IBOutlet weak var round2Button: UIButton!
    @IBOutlet weak var round3Button: UIButton!
    @IBOutlet weak var round4Button: UIButton!
    @IBOutlet weak var round5Button: UIButton!
    @IBOutlet weak var round6Button: UIButton!
    @IBOutlet weak var round7Button: UIButton!
    @IBOutlet weak var round8Button: UIButton!
    @IBOutlet weak var round9Button: UIButton!
    @IBOutlet weak var round10Button: UIButton!
    @IBOutlet weak var round11Button: UIButton!
    @IBOutlet weak var round12Button: UIButton!
    @IBOutlet weak var topic1Label: UILabel!
    @IBOutlet weak var topic2Label: UILabel!
    @IBOutlet weak var topic3Label: UILabel!
    @IBOutlet weak var topic4Label: UILabel!
    @IBOutlet weak var topic5Label: UILabel!
    @IBOutlet weak var topic6Label: UILabel!
    
    
    
    
    var gameNumber = "1938492833"
    var ref:FIRDatabaseReference?
    var round = Int()
    var roundScore1 = ""
    var roundScore2 = ""
    var roundScore3 = ""
    var roundScore4 = ""
    var roundScore5 = ""
    var roundScore6 = ""
    var roundScore7 = ""
    var roundScore8 = ""
    var roundScore9 = ""
    var roundScore10 = ""
    var roundScore11 = ""
    var roundScore12 = ""
    var roundTopic1 = ""
    var roundTopic2 = ""
    var roundTopic3 = ""
    var roundTopic4 = ""
    var roundTopic5 = ""
    var roundTopic6 = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        peliNumero.text = gameNumber
        UserDefaults.standard.set(gameNumber, forKey: "currentGameSaved")
        lataaPisteetVerkosta()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func lataaPisteetVerkosta(){
        
        print ("aloitetaan purkaus")
        print (self.gameNumber)
        //ladataan tietokannasta pisteet
        
        ref?.child("Games").child(gameNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let kierros = value?["playedRounds"] as! Int
            self.round = kierros + 1
            
            
            print(kierros)
            
            if kierros == 0{
                //alustetaan nappulat, jos ei aikaisemmin pelatttu
                self.round1Button.setTitle("Pelaa", for: .normal)
                self.round2Button.setTitle("(ei valmis)", for: .normal)
                self.round3Button.setTitle("(ei valmis)", for: .normal)
                self.round4Button.setTitle("(ei valmis)", for: .normal)
                self.round5Button.setTitle("(ei valmis)", for: .normal)
                self.round6Button.setTitle("(ei valmis)", for: .normal)
                self.round7Button.setTitle("(ei valmis)", for: .normal)
                self.round8Button.setTitle("(ei valmis)", for: .normal)
                self.round9Button.setTitle("(ei valmis)", for: .normal)
                self.round10Button.setTitle("(ei valmis)", for: .normal)
                self.round11Button.setTitle("(ei valmis)", for: .normal)
                self.round12Button.setTitle("(ei valmis)", for: .normal)
                
            }
            
            if kierros >= 1 {
            self.roundScore1 = (value?["round1"] as? String)!
            self.round1Button.setTitle(self.roundScore1, for: .normal)
            self.roundTopic1 = (value?["topic1"] as? String)!
            self.topic1Label.text = self.roundTopic1
            self.round2Button.setTitle("Pelaa", for: .normal)
            
            }
            
            if kierros >= 2 {
            self.roundScore2 = (value?["round2"] as? String)!
            self.round2Button.setTitle(self.roundScore2, for: .normal)
                self.round3Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 3 {
            self.roundScore3 = (value?["round3"] as? String)!
            self.round3Button.setTitle(self.roundScore3, for: .normal)
                self.roundTopic2 = (value?["topic2"] as? String)!
                self.topic2Label.text = self.roundTopic2
                self.round4Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 4 {
            self.roundScore4 = (value?["round4"] as? String)!
            self.round4Button.setTitle(self.roundScore4, for: .normal)
                self.round5Button.setTitle("Pelaa", for: .normal)
                
            }
            
            if kierros >= 5 {
            self.roundScore5 = (value?["round5"] as? String)!
            self.round5Button.setTitle(self.roundScore5, for: .normal)
                self.roundTopic3 = (value?["topic3"] as? String)!
                self.topic3Label.text = self.roundTopic3
                self.round6Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 6 {
            self.roundScore6 = (value?["round6"] as? String)!
            self.round6Button.setTitle(self.roundScore6, for: .normal)
                self.round7Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 7 {
            self.roundScore7 = (value?["round7"] as? String)!
            self.round7Button.setTitle(self.roundScore7, for: .normal)
                self.roundTopic4 = (value?["topic4"] as? String)!
                self.topic4Label.text = self.roundTopic4
                self.round8Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 8 {
            self.roundScore8 = (value?["round8"] as? String)!
            self.round8Button.setTitle(self.roundScore8, for: .normal)
                self.round9Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 9 {
            self.roundScore9 = (value?["round9"] as? String)!
            self.round9Button.setTitle(self.roundScore9, for: .normal)
                self.roundTopic5 = (value?["topic5"] as? String)!
                self.topic5Label.text = self.roundTopic5
                self.round10Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 10 {
            self.roundScore10 = (value?["round10"] as? String)!
            self.round10Button.setTitle(self.roundScore10, for: .normal)
                self.round11Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 11 {
            self.roundScore11 = (value?["round11"] as? String)!
            self.round11Button.setTitle(self.roundScore11, for: .normal)
                self.roundTopic6 = (value?["topic6"] as? String)!
                self.topic6Label.text = self.roundTopic6
                self.round12Button.setTitle("Pelaa", for: .normal)
            }
            
            if kierros >= 12 {
            self.roundScore12 = (value?["round12"] as? String)!
            self.round12Button.setTitle(self.roundScore12, for: .normal)
            }
            
        }) { (error) in
            print("VIRHE!!!")
            print(error.localizedDescription)
        }
    }
    @IBAction func round1ButtonAction(_ sender: UIButton) {
        if round == 1{
            let category = 1
            performSegue(withIdentifier: "showCategorySegue", sender: category)
            
        }
        
    }
    @IBAction func round2ButtonAction(_ sender: UIButton) {
        
    }
    @IBAction func round3ButtonAction(_ sender: UIButton) {
        if round == 3{
            let category = 2
            performSegue(withIdentifier: "showCategorySegue", sender: category)
            
        }
    }
    @IBAction func round4ButtonAction(_ sender: UIButton) {
        
    }
    @IBAction func round5ButtonAction(_ sender: UIButton) {
        if round == 5{
            let category = 3
            performSegue(withIdentifier: "showCategorySegue", sender: category)
            
        }
    }
    @IBAction func round6ButtonAction(_ sender: UIButton) {
        
    }
    @IBAction func round7ButtonAction(_ sender: UIButton) {
        if round == 7{
            let category = 4
            performSegue(withIdentifier: "showCategorySegue", sender: category)
            
        }
    }
    @IBAction func round8ButtonAction(_ sender: UIButton) {
        
    }
    @IBAction func round9ButtonAction(_ sender: UIButton) {
        if round == 9{
            let category = 5
            performSegue(withIdentifier: "showCategorySegue", sender: category)
            
        }
    }
    @IBAction func round10ButtonAction(_ sender: UIButton) {
        
    }
    @IBAction func round11ButtonAction(_ sender: UIButton) {
        if round == 11{
            let category = 6
            performSegue(withIdentifier: "showCategorySegue", sender: category)
            
        }
    }
    @IBAction func round12ButtonAction(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let guest : ScoreViewController = segue.destination as! ScoreViewController
        //guest.gameNumber = sender as! String
        //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCategorySegue" {
            let controller = segue.destination as! CategoryViewController
            controller.numberOfCategoryToChoose = sender as! Int
            
        } else if segue.identifier == "addQuestionSegue" {
            //let controller = segue.destination as! ComposeViewController
            //controller.history = self.history
        }
    }

    
    
    

}

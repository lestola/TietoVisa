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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        
        peliNumero.text = gameNumber
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
            
            print(kierros)
            
            
            if kierros >= 1 {
            self.roundScore1 = (value?["round1"] as? String)!
            self.round1Button.setTitle(self.roundScore1, for: .normal)
            }
            
            if kierros >= 2 {
            self.roundScore2 = (value?["round2"] as? String)!
            self.round2Button.setTitle(self.roundScore2, for: .normal)
            }
            
            if kierros >= 3 {
            self.roundScore3 = (value?["round3"] as? String)!
            self.round3Button.setTitle(self.roundScore3, for: .normal)
            }
            
            if kierros >= 4 {
            self.roundScore4 = (value?["round4"] as? String)!
            self.round4Button.setTitle(self.roundScore4, for: .normal)
            }
            
            if kierros >= 5 {
            self.roundScore5 = (value?["round5"] as? String)!
            self.round5Button.setTitle(self.roundScore5, for: .normal)
            }
            
            if kierros >= 6 {
            self.roundScore6 = (value?["round6"] as? String)!
            self.round6Button.setTitle(self.roundScore6, for: .normal)
            }
            
            if kierros >= 7 {
            self.roundScore7 = (value?["round7"] as? String)!
            self.round7Button.setTitle(self.roundScore7, for: .normal)
            }
            
            if kierros >= 8 {
            self.roundScore8 = (value?["round8"] as? String)!
            self.round8Button.setTitle(self.roundScore8, for: .normal)
            }
            
            if kierros >= 9 {
            self.roundScore9 = (value?["round9"] as? String)!
            self.round9Button.setTitle(self.roundScore9, for: .normal)
            }
            
            if kierros >= 10 {
            self.roundScore10 = (value?["round10"] as? String)!
            self.round10Button.setTitle(self.roundScore10, for: .normal)
            }
            
            if kierros >= 11 {
            self.roundScore11 = (value?["round11"] as? String)!
            self.round11Button.setTitle(self.roundScore11, for: .normal)
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

}

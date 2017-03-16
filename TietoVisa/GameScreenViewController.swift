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
  
    var ref:FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
        lataaKysymysTietokannasta()
    }
    
    
    func lataaKysymysTietokannasta(){
    //TODO: tähän tulee koodi joka lataa kysymyksen tietokanasta, sekä kysymykseen liitetyt väärät, sekä oikean vastauksen nappuloihin
        ref?.child("Kysymykset").child("Elokuvat").child("kysymys1").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let kysymys = value?["question"] as? String ?? ""
            
            self.kysymysLabel.text = kysymys
            
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

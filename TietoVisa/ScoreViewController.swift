//
//  ScoreViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 27.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    
    @IBOutlet weak var peliNumero: UILabel!
    
    var gameNumber = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        peliNumero.text = gameNumber
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//
//  LogInViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 23.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class LogInViewController: UIViewController  {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //kirjaudutaan sisään tunnuksilla jos ne on aikaisemmin syötetty
        if let email = UserDefaults.standard.object(forKey: "savedEmail") as? String, let pass = UserDefaults.standard.object(forKey: "savedPassword") as? String
        {
                FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                    //katsotaan ettei user ole tyhjä
                    if user != nil {
                        //käyttäjä löydetty, mene kotisivulle
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else{
                        //virhe, tarkista virhe ja näytä viesti
                        
                    }
                })
            

        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        //Flipataan booleania
        isSignIn = !isSignIn
        
        //chekkaa nappula ja muuta nappuloitten ja labeleitten asetukset
        if isSignIn{
            signInLabel.text = "Kirjaudu"
            signInButton.setTitle("Kirjaudu sisään", for: .normal)
        }
        else{
            signInLabel.text = "Rekisteröidy"
            signInButton.setTitle("Rekisteröidy", for: .normal)
        }
        
    }
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        //TODO: tarkistetaan onko salasana ja tunnus tekstit tyhjiä
        
        if let email = emailTextField.text, let pass = passwordTextField.text {
            
            // tsekataan onko kirjautudttu sisään, vai reksiteröidystäänkö=
            if isSignIn{
                //kirjaudutaan sisään
                FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                    //katsotaan ettei user ole tyhjä
                    if let u = user {
                        //käyttäjä löydetty, mene kotisivulle
                        UserDefaults.standard.set(self.emailTextField.text, forKey: "savedEmail")
                        UserDefaults.standard.set(self.passwordTextField.text, forKey: "savedPassword")
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else{
                        //virhe, tarkista virhe ja näytä viesti
                        
                    }
                })
            }
            else{
                //rekisteröidytään firebaseen
                
                FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                    
                    //tarkistetaan ettei käyttäjänimi ole tyhjä
                    if let u = user {
                        //käyttäjä löytyi.. mennään kotisivulle
                        UserDefaults.standard.set(self.emailTextField.text, forKey: "savedEmail")
                        UserDefaults.standard.set(self.passwordTextField.text, forKey: "savedPassword")
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else{
                        //error: näytä error viesti
                    }
                })
            }

            
        }
        
        
        
        
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        //Dismiss the keyboard when teh view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

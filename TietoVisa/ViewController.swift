//
//  ViewController.swift
//  TietoVisa
//
//  Created by Marko Lehtola on 9.3.2017.
//  Copyright © 2017 Marko Lehtola. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameButton: UIBarButtonItem!
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    let user = FIRAuth.auth()?.currentUser
    
    
    var postData = [String]()
    
    var allWaitingGames = [Int]()
    var allWaitingGamesHandle:FIRDatabaseHandle?
    var allOwnGames = [String]()
    var allOwnGamesHandle:FIRDatabaseHandle?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TÄLLÄ SAA NÄKYMÄÄN EMAIL OSOITTEEN YLÄKULMASSA
        /*if let x = UserDefaults.standard.object(forKey: "savedEmail") as? String
         {
         usernameButton.title = x
         
         }*/
        
        //TÄLLÄ SAA NÄKYMÄÄN UID:N YLÄKULMASSA
        
        usernameButton.title = user?.uid
        
        
        //TÄLLÄ SAA NÄKYMÄÄN EMAILIM YLÄKULMASSA SUORAAN REFIN KAUTTA
        
        //usernameButton.title = user?.email
        
        
        
        

        
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //set the firebase reference
        ref =  FIRDatabase.database().reference()
        
        
        //retrieve the post and listen for changes
        //alkuperäinen
        //databaseHandle = ref?.child("Kysymykset").child("Elokuvat").child("kysymys1").observe(.childAdded, with: { (snapshot) in
        
        /*
         databaseHandle = ref?.child("posts").observe(.childAdded, with: { (snapshot) in
         
         //kun lapsi lisätään posteihin
         //ota arvo snapshotista ja laita se postDatataan
         let post = snapshot.value as? String
         
         if let actualPost = post {
         
         //laita postidata sinne minnekuuluu eli post data arrayhin
         self.postData.append(actualPost)
         
         //päivitä teblevievin sisältö
         self.tableView.reloadData()
         }
 */
        
        databaseHandle = ref?.child("UserData").child((user?.uid)!).child("Games").observe(.childAdded, with: { (snapshot) in
            
            ///kun lapsi lisätään posteihin
            //ota arvo snapshotista ja laita se postDatataan
            let post = snapshot.value as? String
            if let actualPost = post {
                
                //laita postidata sinne minnekuuluu eli post data arrayhin
                self.postData.append(actualPost)
                
                //päivitä tablevievin sisältö
                self.tableView.reloadData()
            }
        })
        
        //tehdään handle odottaviin peleihin
        allWaitingGamesHandle = ref?.child("Games").child("waiting").observe(.childAdded, with: { (snapshot) in
            
            ///kun lapsi lisätään posteihin
            //ota arvo snapshotista ja laita se postDatataan
            let post = snapshot.value as? Int
            if let actualPost = post {
                
                //laita postidata sinne minnekuuluu eli post data arrayhin
                self.allWaitingGames.append(actualPost)
                
                
            }
        })
        
        //tehään handle omiin peleihin
        allOwnGamesHandle = ref?.child("UserData").child((user?.uid)!).child("Games").observe(.childAdded, with: { (snapshot) in
            
            ///kun lapsi lisätään posteihin
            //ota arvo snapshotista ja laita se postDatataan
            let post = snapshot.value as? String
            if let actualPost = post {
                
                //laita postidata sinne minnekuuluu eli post data arrayhin
                self.allOwnGames.append(actualPost)
                
                
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        //tämäkin toimisi varmasti.. en ole jaksanut kokeilla.. yksinkertaisempi:
        //let cell = UITableViewCell()
        //cell.textLabel?.text = postData[indexPath.row]
        //return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "scoreScreenSeque", sender: postData[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let guest : ScoreViewController = segue.destination as! ScoreViewController
        //guest.gameNumber = sender as! String
        //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "scoreScreenSeque" {
                let controller = segue.destination as! ScoreViewController
                controller.gameNumber = sender as! String
            } else if segue.identifier == "addQuestionSegue" {
                //let controller = segue.destination as! ComposeViewController
                //controller.history = self.history
            }
    }
    @IBAction func addGameButtonAction(_ sender: UIBarButtonItem) {
        //tässä osiossa kerrotaan mitä tapahtuu, kun painetaan "uusi peli" nappulaa
        //tarkistetaan onko pelejä joihin voi liittyä
        
        //haetaan databasesta pelien numerot joihin voi liittyä
                //tarkistetaan ettei liitytä omaan peliin ja jos ei oma, niin liitytään!/ siirrytään tekemään uusi peli, jos ei listalla ole yhtään peliä
        print(self.allWaitingGames.count)
        
        
        if self.allWaitingGames.count > 0 {
            //------------------------------
            //selataan läpi peli lista
            print("listalla oli pelejä")
            
            var freeGame = Int()
            for gameNumber in self.allWaitingGames {
                print(gameNumber)
                var canJoin = true
                for ownGameNumber in self.allOwnGames{
                    let gameNumberAsString = String(gameNumber)
                    if ownGameNumber == gameNumberAsString {
                        print("sama numero")
                        canJoin = false
                    }
                }
                
                if canJoin {
                    freeGame = gameNumber
                }
            }
            //--------------------------------------
            //kun peli on löytynyt, liitytään siihen!!
            print("peli johon tullaan liittymään", freeGame)
            
            let userAsString = String((user?.uid)!)!
            //lisätään peliin oma uid
            let childUpdates = ["/Games/\(String(freeGame))/player2/": userAsString]
            ref?.updateChildValues(childUpdates)
            
            //poistetaan peli jonotuslistalta
            ref?.child("Games").child("waiting").child(String(freeGame)).removeValue()
            
            //postataan peli omiin meneillään oleviin peleihin
            let ownGamesUpdate = ["/UserData/\(String((user?.uid)!)!)/Games/\(freeGame)": String(freeGame)]
            ref?.updateChildValues(ownGamesUpdate)
        }
            
        else{
        
            //----------------------------
            //tehdään uusi peli
            //arvotaan eka pelille numero
            let randomGameNumber = arc4random_uniform(UInt32(10000000))
            print("pelinumero:")
            print(randomGameNumber)
        
            //postataan pelinumerolla oleva peli peleihin
            let post = ["playedRounds": 0,
                    "player1": user?.uid,
                    "player2": "waiting"] as [String : Any]
        
            let childUpdates = ["/Games/\(randomGameNumber)": post]
            ref?.updateChildValues(childUpdates)
            //postataan peliä odottava peli waiting listalle
            let gameNumberUpdate = ["/Games/waiting/\(randomGameNumber)": randomGameNumber]
            ref?.updateChildValues(gameNumberUpdate)
            //postataan peli omiin meneillään oleviin peleihin
       
            let ownGamesUpdate = ["/UserData/\(String((user?.uid)!)!)/Games/\(randomGameNumber)": String(randomGameNumber)]
            ref?.updateChildValues(ownGamesUpdate)
        }
    }
}


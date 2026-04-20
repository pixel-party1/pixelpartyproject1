//
//  LoginViewController.swift
//  pixel party
//
//  Created by Roome, Ellis on 15/04/2026.
//

import UIKit
import CoreData
import CryptoKit

class LoginViewController: UIViewController {
    
    var users: [User] = []
    var userExists: Bool = false
    
    @IBAction func backToSettings(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        userExists = false
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let checkPassValue = hash(password)
        
        for user in users where !userExists {
            if (username.isEqual(user.username)) {
                userExists = true
                if checkPassValue.isEqual(user.hashedPassword) {
                    //login success
                    UserDefaults.standard.set(true, forKey: "signedIn")
                    UserDefaults.standard.set(username, forKey: "currentUser")
                    let alert = UIAlertController(title: "User \(username) signed in.", message: "Have fun!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(okAction)
                    present(alert, animated: true)
                    
                } else {
                    //wrong password
                    let alert = UIAlertController(title: "Incorrect password", message: "Please try again", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    present(alert, animated: true)
                }
            }
        }
        if (userExists == false) {
            let alert = UIAlertController(title: "User does not exist", message: "Please try again", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
    }
    
    func fetchUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            users = try managedContext.fetch(fetchRequest) as! [User]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func hash(_ input: String) -> String {
        let hashOutput = SHA256.hash(data: Data(input.utf8))
        
        let hashString = hashOutput.map {String(format: "%02x", $0) }.joined()
        return hashString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchUsers()
    }
    

}

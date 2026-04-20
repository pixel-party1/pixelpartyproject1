//
//  RegisterViewController.swift
//  pixel party
//
//  Created by Roome, Ellis on 15/04/2026.
//

import UIKit
import CoreData
import CryptoKit

class RegisterViewController: UIViewController {
    
    var users: [User] = []
    var userExists: Bool = false

    @IBAction func backToSettings(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    // Text fields
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    //Press register
    @IBAction func submit(_ sender: Any) {
        userExists = false
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let confirmPassword = confirmPasswordField.text ?? ""
        
        let validUN = usernameValid(username)
        let validPW = passwordValid(password)
        
        if password.isEqual(confirmPassword) {
            for user in users {
                if username.isEqual(user.username) {
                    userExists = true
                }
            }
            if userExists == false && validPW && validUN {
                let hashed = hash(password)
                storeUser(theUsername: username, theHashedPassword: hashed)
                UserDefaults.standard.set(true, forKey: "signedIn")
                UserDefaults.standard.set(username, forKey: "currentUser")
                let alert = UIAlertController(title: "User registered", message: "Successfully created local user account", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                present(alert, animated: true)
            } else if userExists == true {
                let alert = UIAlertController(title: "Username already exists", message: "An account with this username already exists", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            
            } else if !validUN {
                let alert = UIAlertController(title: "Invalid Username", message: "Username must be 4-16 characters long", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            } else if !validPW {
                let alert = UIAlertController(title: "Invalid Password", message: "Password must be 8-20 characters long and include letters and numbers", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            }
        } else if password.isEqual(confirmPassword) == false {
            let alert = UIAlertController(title: "Passwords do not match", message: "Confirm password must match password", preferredStyle: .alert)
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
    
    func storeUser(theUsername: String, theHashedPassword: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as! User
        
        user.username = theUsername
        user.hashedPassword = theHashedPassword
        
        do {
            try managedContext.save()
            users.append(user)
            print("SAVED")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func hash(_ input: String) -> String {
        let hashOutput = SHA256.hash(data: Data(input.utf8))
        
        let hashString = hashOutput.map {String(format: "%02x", $0) }.joined()
        return hashString
    }
    
    func usernameValid (_ input: String) -> Bool {
        let length = input.count
        if length < 4 {
            return false
        } else if length > 16 {
            return false
        } else {
            return true
        }
    }
    
    func passwordValid (_ input: String) -> Bool {
        let length = input.count
        if length < 8 {
            return false
        } else if length > 20 {
            return false
        } else {
            var letter = false
            var number = false
            
            for c in input {
                if c.isLetter {
                    letter = true
                }
                if c.isNumber {
                    number = true
                }
            }
            return letter && number
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userExists = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchUsers()
    }
}

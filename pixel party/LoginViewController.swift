//
//  LoginViewController.swift
//  pixel party
//
//  Created by Roome, Ellis on 15/04/2026.
//

import UIKit
import CryptoKit

class LoginViewController: UIViewController {

    @IBAction func backToSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let checkPassValue = hash(password)
        
        
        
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
    

}

//
//  MainMenuViewController.swift
//  pixel party
//
//  Created by Mitev, Viktor on 03/03/2026.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBAction func LeaderboardButton(_ sender: UIButton) {
        AudioManager.shared.playButtonClick()
        performSegue(withIdentifier: "toLeaderboard", sender: sender)
    }
    
    @IBAction func StartButton(_ sender: UIButton) {
        AudioManager.shared.playButtonClick()
        performSegue(withIdentifier: "toGameSelect", sender: sender)
    }
    
    @IBAction func SettingsButton(_ sender: UIButton) {
        AudioManager.shared.playButtonClick()
        performSegue(withIdentifier: "toSettings", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioManager.shared.playMusic()
        // Do any additional setup after loading the view.
        // test 
    }
}

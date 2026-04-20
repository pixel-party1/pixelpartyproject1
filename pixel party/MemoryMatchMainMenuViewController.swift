//
//  MemoryMatchMainMenuViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 18/03/2026.
//

import UIKit

class MemoryMatchMainMenuViewController: UIViewController {
    
    
    @IBOutlet weak var memoryMatchTitleLabel: UILabel!
    
    @IBOutlet weak var memoryMatchPlayButtonText: UIButton!
    
    @IBAction func memoryMatchHomeButtonPressed(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var memoryMatchHowToPlayButtonText: UIButton!
    
    
    
    @IBAction func memoryMatchPlayButtonPressed(_ sender: Any) {
        AudioManager.shared.playButtonClick()
    }
    
    @IBAction func memoryMatchHowToPlayButtonPressed(_ sender: Any) {
        AudioManager.shared.playButtonClick()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memoryMatchTitleLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
        
        // makes play button rounded
        memoryMatchPlayButtonText.layer.cornerRadius = 25
        memoryMatchPlayButtonText.clipsToBounds = true
            
        // makes how to play button rounded
        memoryMatchHowToPlayButtonText.layer.cornerRadius = 25
        memoryMatchHowToPlayButtonText.clipsToBounds = true
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MemoryMatchMediumModeViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 19/03/2026.
//

import UIKit

class MemoryMatchMediumModeViewController: UIViewController {
    
    
    @IBAction func memoryMatchMediumModeBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var clockDisplay: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    @IBOutlet weak var card3: UIButton!
    @IBOutlet weak var card4: UIButton!
    @IBOutlet weak var card5: UIButton!
    @IBOutlet weak var card6: UIButton!
    @IBOutlet weak var card7: UIButton!
    @IBOutlet weak var card8: UIButton!
    @IBOutlet weak var card9: UIButton!
    @IBOutlet weak var card10: UIButton!
    @IBOutlet weak var card11: UIButton!
    @IBOutlet weak var card12: UIButton!
    @IBOutlet weak var card13: UIButton!
    @IBOutlet weak var card14: UIButton!
    @IBOutlet weak var card15: UIButton!
    @IBOutlet weak var card16: UIButton!
    
    var cardValues = [
    "chipmunk", "chipmunk",
    "hive", "hive",
    "log", "log",
    "mushroom", "mushroom",
    "pickaxe", "pickaxe",
    "rabbit", "rabbit",
    "rock", "rock",
    "tree", "tree"
    ]
    
    var buttons: [UIButton] = []
    
    var firstIndex: Int?
    var secondIndex: Int?
    
    var firstButton: UIButton?
    var secondButton: UIButton?
    
    var matchedPairs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockDisplay.text = "00"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        clockDisplay.text = String(format: "%02d:%02d", minutes,seconds)
        clockDisplay.font = UIFont(name: "Kenney-Rocket", size: 30)
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

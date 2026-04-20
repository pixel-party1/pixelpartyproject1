//
//  MemoryMatchHardModeViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 19/03/2026.
//

import UIKit

class MemoryMatchHardModeViewController: UIViewController {
    
    // basically just copied the code from easy again
    
    // go back to previous screen
    @IBAction func memoryMatchHardModeBackButtonPressed(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    // basic timer setup got this from my comp228 module
    @IBOutlet weak var clockDisplay: UILabel!
    
    var timer: Timer?
    var timerCount = 0

    // all card buttons (easy mode = 36 cards)
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
    @IBOutlet weak var card17: UIButton!
    @IBOutlet weak var card18: UIButton!
    @IBOutlet weak var card19: UIButton!
    @IBOutlet weak var card20: UIButton!
    @IBOutlet weak var card21: UIButton!
    @IBOutlet weak var card22: UIButton!
    @IBOutlet weak var card23: UIButton!
    @IBOutlet weak var card24: UIButton!
    @IBOutlet weak var card25: UIButton!
    @IBOutlet weak var card26: UIButton!
    @IBOutlet weak var card27: UIButton!
    @IBOutlet weak var card28: UIButton!
    @IBOutlet weak var card29: UIButton!
    @IBOutlet weak var card30: UIButton!
    @IBOutlet weak var card31: UIButton!
    @IBOutlet weak var card32: UIButton!
    @IBOutlet weak var card33: UIButton!
    @IBOutlet weak var card34: UIButton!
    @IBOutlet weak var card35: UIButton!
    @IBOutlet weak var card36: UIButton!
    
    // pairs of values (2 of each = match system)
    var cardValues = [
    "barrier", "barrier",
    "bench", "bench",
    "bin", "bin",
    "box", "box",
    "crate", "crate",
    "fire_hydrant", "fire_hydrant",
    "green_tree", "green_tree",
    "red_tree", "red_tree",
    "person1", "person1",
    "person2", "person2",
    "person3", "person3",
    "person4", "person4",
    "person5", "person5",
    "person6", "person6",
    "postbox", "postbox",
    "tires", "tires",
    "traffic_light", "traffic_light",
    "cone", "cone"
    ]
    
    // makes it easier to loop through cards instead of handling each one manually
    var buttons: [UIButton] = []
    
    // track which cards are currently selected
    var firstIndex: Int?
    var secondIndex: Int?
    
    var firstButton: UIButton?
    var secondButton: UIButton?
    
    // used to check if player has won
    var matchedPairs = 0
    
    
    @IBAction func hardModeResetButtonPressed(_ sender: Any) {
        
        // reset timer back to 0 and start again
        restartTimer()
        
        // reset game state
            matchedPairs = 0
            firstIndex = nil
            secondIndex = nil
            firstButton = nil
            secondButton = nil
            
            // reshuffle cards
            cardValues.shuffle()
            
            // flip all cards back over + reenable them
            for button in buttons {
                button.isEnabled = true
                button.setImage(UIImage(named: "back_of_card"), for: .normal)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockDisplay.text = "00"
        
        // start timer when screen loads
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        // shuffle cards at start
        cardValues.shuffle()
        
        // stored buttons in array for easier handling
        buttons = [
            card1,
            card2,
            card3,
            card4,
            card5,
            card6,
            card7,
            card8,
            card9,
            card10,
            card11,
            card12,
            card13,
            card14,
            card15,
            card16,
            card17,
            card18,
            card19,
            card20,
            card21,
            card22,
            card23,
            card24,
            card25,
            card26,
            card27,
            card28,
            card29,
            card30,
            card31,
            card32,
            card33,
            card34,
            card35,
            card36
        ]
        
        // set all cards face down
        for button in buttons {
            button.setImage(UIImage(named: "back_of_card"), for: .normal)
        }

    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        //format in minutes and seconds not just seconds
        clockDisplay.text = String(format: "%02d:%02d", minutes,seconds)
        
        // custom font for game feel
        clockDisplay.font = UIFont(name: "Kenney-Rocket", size: 30)
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        AudioManager.shared.playCardFlip()
        
        if let index = buttons.firstIndex(of: sender) {
                
                let value = cardValues[index]
                
                // added flip animation when revealing card to look nicer
                UIView.transition(with: sender,
                              duration: 0.4,
                              options: .transitionFlipFromLeft,
                              animations: {
                
                sender.setImage(UIImage(named: value), for: .normal)
                
                }, completion: nil)
                
                // first card selected
                if firstIndex == nil {
                    firstIndex = index
                    firstButton = sender
                
                // second card selected so now we can check for a match
                } else if secondIndex == nil {
                    secondIndex = index
                    secondButton = sender
                    
                    checkMatch()
                }
            }
    }
    
    func checkMatch() {
        
        if let first = firstIndex,
           let second = secondIndex,
           let button1 = firstButton,
           let button2 = secondButton {
            
            // if the two selected cards match
            if cardValues[first] == cardValues[second] {
                
                // just for debugging
                print("Match!")
                
                // disable so they can't be tapped again
                button1.isEnabled = false
                button2.isEnabled = false
                
                matchedPairs += 1
                
                // win condition (18 pairs in easy mode)
                if matchedPairs == 18 {
                    showWinScreen()
                }
                
            } else {
                
                // just for debugging
                print("No match")
                
                // flip both cards after short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    UIView.transition(with: button1,
                                      duration: 0.4,
                                      options: .transitionFlipFromLeft,
                                      animations: {
                        
                        button1.setImage(UIImage(named: "back_of_card"), for: .normal)
                        
                    }, completion: nil)

                    UIView.transition(with: button2,
                                      duration: 0.4,
                                      options: .transitionFlipFromLeft,
                                      animations: {
                        
                        button2.setImage(UIImage(named: "back_of_card"), for: .normal)
                        
                    }, completion: nil)
                    
                }
            }
            
            // reset selection so next turn works properly
            firstIndex = nil
            secondIndex = nil
            firstButton = nil
            secondButton = nil
        }
    }
    
    func showWinScreen() {
        
        //stop timer so final time is frozen
        timer?.invalidate()
        timer = nil
        
        AudioManager.shared.playWin()
            
        let alert = UIAlertController(title: "You Win!",
                                      message: "You matched all the pairs!",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            
            // restart everything cleanly
            self.restartTimer()
            self.resetGame()
        }))
        
        self.present(alert, animated: true)
    }
    
    func resetGame() {
        
        matchedPairs = 0
        cardValues.shuffle()
        
        //reset all cards to intial state
        for button in buttons {
            button.isEnabled = true
            button.setImage(UIImage(named: "back_of_card"), for: .normal)
        }
    }
    
    func restartTimer() {
        
        // make sure old timer is gone before starting new one
        timer?.invalidate()
        timer = nil
        
        timerCount = 0
        clockDisplay.text = "00:00"
        
        //start fresh timer
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerFired),
                                     userInfo: nil,
                                     repeats: true)
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

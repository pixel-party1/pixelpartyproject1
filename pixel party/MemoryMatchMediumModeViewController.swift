//
//  MemoryMatchMediumModeViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 19/03/2026.
//

import UIKit

class MemoryMatchMediumModeViewController: UIViewController {
    
    // basically just copied the code from easy just added more cards and changed some conditions
    
    // go back to previous screen
    @IBAction func memoryMatchMediumModeBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // basic timer setup got this from my comp228 module
    @IBOutlet weak var clockDisplay: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    // all card buttons (easy mode = 16 cards)
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
    
    // pairs of values (2 of each = match system)
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
    
    // makes it easier to loop through cards instead of handling each one manually
    var buttons: [UIButton] = []
    
    // track which cards are currently selected
    var firstIndex: Int?
    var secondIndex: Int?
    
    var firstButton: UIButton?
    var secondButton: UIButton?
    
    // used to check if player has won
    var matchedPairs = 0
    
    @IBAction func mediumModeButtonPressed(_ sender: Any) {
        
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
            card16
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
                
                // win condition (8 pairs in medium mode)
                if matchedPairs == 8 {
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
            
        let alert = UIAlertController(title: "You Win! 🎉",
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

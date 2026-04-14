//
//  MemoryMatchEasyModeViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 19/03/2026.
//

import UIKit

class MemoryMatchEasyModeViewController: UIViewController {
    
    
    @IBAction func memoryMatchEasyModeBackButtonPressed(_ sender: Any) {
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
    
    var cardValues = ["burger", "burger", "sushi", "sushi", "pizza", "pizza"]
    
    var buttons: [UIButton] = []
    
    var firstIndex: Int?
    var secondIndex: Int?
    
    var firstButton: UIButton?
    var secondButton: UIButton?
    
    var matchedPairs = 0
    
    
    @IBAction func easyModeRestartButtonPressed(_ sender: Any) {
        
        restartTimer()
        
        // reset game state
            matchedPairs = 0
            firstIndex = nil
            secondIndex = nil
            firstButton = nil
            secondButton = nil
            
            // reshuffle cards
            cardValues.shuffle()
            
            // reset all buttons
            for button in buttons {
                button.isEnabled = true
                button.setImage(UIImage(named: "back_of_card"), for: .normal)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockDisplay.text = "00"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        cardValues.shuffle()
        
        buttons = [card1, card2, card3, card4, card5, card6]
        
        for button in buttons {
            button.setImage(UIImage(named: "back_of_card"), for: .normal)
        }
    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        clockDisplay.text = String(format: "%02d:%02d", minutes,seconds)
        clockDisplay.font = UIFont(name: "Kenney-Rocket", size: 30)
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        
        if let index = buttons.firstIndex(of: sender) {
                
                let value = cardValues[index]
                
                UIView.transition(with: sender,
                              duration: 0.4,
                              options: .transitionFlipFromLeft,
                              animations: {
                
                sender.setImage(UIImage(named: value), for: .normal)
                
                }, completion: nil)
                
                // First card
                if firstIndex == nil {
                    firstIndex = index
                    firstButton = sender
                    
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
            
            // If match
            if cardValues[first] == cardValues[second] {
                
                print("Match!")
                
                button1.isEnabled = false
                button2.isEnabled = false
                
                matchedPairs += 1
                
                // check win
                if matchedPairs == 3 {
                    showWinScreen()
                }
                
            } else {
                
                print("No match")
                
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
            
            // reset selections
            firstIndex = nil
            secondIndex = nil
            firstButton = nil
            secondButton = nil
        }
    }
    
    func showWinScreen() {
        
        // STOP TIMER FIRST
            timer?.invalidate()
            timer = nil
            
        let alert = UIAlertController(title: "You Win! 🎉",
                                      message: "You matched all the pairs!",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.restartTimer()
            self.resetGame()
        }))
        
        self.present(alert, animated: true)
    }
    
    func resetGame() {
        
        matchedPairs = 0
        cardValues.shuffle()
        
        for button in buttons {
            button.isEnabled = true
            button.setImage(UIImage(named: "back_of_card"), for: .normal)
        }
    }
    
    func restartTimer() {
        
        timer?.invalidate()
        timer = nil
        
        timerCount = 0
        clockDisplay.text = "00:00"
        
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

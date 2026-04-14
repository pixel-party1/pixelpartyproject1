//
//  MazeGameMediumModeViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameMediumModeViewController: UIViewController {

    
    @IBAction func mediumModeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mazeGameMediumModeTimer: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    
    @IBOutlet weak var mediumMazeBoardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        mazeGameMediumModeTimer.text = String(format: "%02d:%02d", minutes, seconds)

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

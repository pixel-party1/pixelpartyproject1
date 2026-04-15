//
//  MemoryMatchHardModeViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 19/03/2026.
//

import UIKit

class MemoryMatchHardModeViewController: UIViewController {
    
    
    @IBAction func memoryMatchHardModeBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var clockDisplay: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockDisplay.text = "00"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
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

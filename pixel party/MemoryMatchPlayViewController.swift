//
//  MemoryMatchPlayViewController.swift
//  pixel party
//

import UIKit

class MemoryMatchPlayViewController: UIViewController {

    @IBOutlet weak var memoryMatchSelectDifficultyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        memoryMatchSelectDifficultyLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
    }

    // MARK: - Difficulty Buttons

    @IBAction func easyButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEasyMode", sender: self)
    }

    @IBAction func mediumButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMediumMode", sender: self)
    }

    @IBAction func hardButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toHardMode", sender: self)
    }

    // MARK: - Back Button
    @IBAction func memoryMatchPlayBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

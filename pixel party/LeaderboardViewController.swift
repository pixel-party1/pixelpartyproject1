//
//  LeaderboardViewController.swift
//  pixel party
//
//  Created by Mitev, Viktor on 03/03/2026.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leaderboardTitleLabel: UILabel!
    
    @IBAction func toHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gameSelector: UISegmentedControl!
    
    var mazeScores: [GameScore] = []
    var memoryScores: [GameScore] = []
    var slideScores: [GameScore] = []
    
    var currentScores: [GameScore] {
        switch gameSelector.selectedSegmentIndex {
        case 0: return mazeScores
        case 1: return memoryScores
        default: return slideScores
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardTitleLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
        tableView.delegate = self
        tableView.dataSource = self
        
        loadMockData()
    }
    
    func loadMockData() {
        mazeScores = [
            GameScore(playerName: "Alpha", score: 1500),
            GameScore(playerName: "Bravo", score: 1200),
            GameScore(playerName: "Charlie", score: 900)
        ]
        
        memoryScores = [
            GameScore(playerName: "Player One", score: 500),
            GameScore(playerName: "Player Two", score: 450),
            GameScore(playerName: "Player Three", score: 300)
        ]
        
        slideScores = [
            GameScore(playerName: "Master", score: 2000),
            GameScore(playerName: "Pro", score: 1800),
            GameScore(playerName: "Noob", score: 100)
        ]
        
        tableView.reloadData()
    }
    
    @IBAction func gameChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentScores.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath)
            let data = currentScores[indexPath.row]
            
            cell.textLabel?.text = "\(indexPath.row + 1). \(data.playerName)"
            cell.detailTextLabel?.text = "\(data.score)"
            return cell
        }
    }

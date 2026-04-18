//
//  MazeGameMediumModeViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameMediumModeViewController: UIViewController {
    var mediumGameEnded = false
    var mediumMaze: [String] = []
    
    var moveCount = 0
    var lastPlayerRow = 0
    var lastPlayerCol = 0
    
    
    @IBOutlet weak var mazeGameMediumModeMoveCounter: UILabel!
    
    
    @IBAction func mazeGameMediumModeResetPressed(_ sender: Any) {
        resetGame()
    }
    
    
    @IBAction func mazeGameMediumModeRandomPressed(_ sender: Any) {
        if let randomMaze = mediumMazes.randomElement() {
            mediumMaze = randomMaze
        }
        
        resetGame()
    }
    
    @IBAction func mediumModeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //maze definition (to be changed when logic is finished)
    let mediumMazes = [[
        "#########",
        "#S..##..#",
        "#....#..#",
        "#..#....#",
        "##..#..##",
        "#.......#",
        "##.#..#.#",
        "#...##G.#",
        "#########",
    ],[
        "#########",
        "#.#....##",
        "#....#..#",
        "#.#.....#",
        "#...#...#",
        "#.....#.#",
        "#.##.##.#",
        "##G.....#",
        "#S...#..#",
        "#########",
    ]
    ]
    
    
    // player position variables
    var playerRow = 0
    var playerCol = 0
    
    //find start position (where it says S on maze)
    func findStartPosition() {
        for row in 0..<mediumMaze.count {
            let currentRow = Array(mediumMaze[row])
            
            for col in 0..<currentRow.count {
                if currentRow[col] == "S" {
                    playerRow = row
                    playerCol = col
                    return
                }
            }
        }
    }
    
    
    @IBOutlet weak var mazeGameMediumModeTimer: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    
    @IBOutlet weak var mediumMazeBoardView: UIView!
    
    func drawMediumMaze(){
        // subviews -  (explaination to be added)
        mediumMazeBoardView.subviews.forEach({$0.removeFromSuperview()})
        
        // Ensure start position is set before drawing
        if playerRow == 0 && playerCol == 0 {
            findStartPosition()
        }
        
        let rows = mediumMaze.count
        let cols = mediumMaze[0].count
        
        // makes the frame more square
        let tileSize = min(mediumMazeBoardView.bounds.width / CGFloat(cols), mediumMazeBoardView.bounds.height / CGFloat(rows)) * 1.2
        
        let totalWidth = tileSize * CGFloat(cols)
        let totalHeight = tileSize * CGFloat(rows)
        
        let xOffset = (mediumMazeBoardView.bounds.width - totalWidth) / 2
        let yOffset = (mediumMazeBoardView.bounds.height - totalHeight) / 2
        
        for row in 0..<rows {
            let currentRow = Array(mediumMaze[row])
            
            for col in 0..<cols {
                let x = xOffset + CGFloat(col) * tileSize
                let y = yOffset + CGFloat(row) * tileSize
                
                let tileView = UIView(frame: CGRect(x: x, y: y, width: tileSize, height: tileSize))
                
                let character = currentRow[col]
                if character == "#" {
                    tileView.backgroundColor = .black
                } else if character == "G" {
                    tileView.backgroundColor = .yellow
                } else {
                    tileView.backgroundColor = .lightGray
                }
                
                tileView.layer.borderWidth = 1
                tileView.layer.borderColor = UIColor.black.cgColor
                
                mediumMazeBoardView.addSubview(tileView)
            }
        }
        
        
        let playerX = xOffset + CGFloat(playerCol) * tileSize
        let playerY = yOffset + CGFloat(playerRow) * tileSize
        
        let playerImageView = UIImageView(frame: CGRect(
            x: playerX,
            y: playerY,
            width: tileSize,
            height: tileSize
        ))

        playerImageView.image = UIImage(named: "velociraptor - medium mode")
        
        mediumMazeBoardView.addSubview(playerImageView)
        // check if player moved
        if playerRow != lastPlayerRow || playerCol != lastPlayerCol {
            moveCount += 1
            updateMoveCounter()
        }

        // update last position
        lastPlayerRow = playerRow
        lastPlayerCol = playerCol
        
    }
    
    // wall check
    func isWall(row: Int, col: Int) -> Bool{
        if row < 0 || row >= mediumMaze.count{
            return true
        }
        
        let currentRow = Array(mediumMaze[row])
        
        if col < 0 || col >= currentRow.count {
            return true
        }
        
        return currentRow[col] == "#"
    }
    
    //
    func checkWin() {
        let currentRow = Array(mediumMaze[playerRow])
        let character = currentRow[playerCol]
        
        if character == "G"{
            mediumGameEnded = true
            timer?.invalidate()
            let alert = UIAlertController(title: "YOU WIN!!", message: "Medium Maze complete", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        if mediumGameEnded {return}
        slideUp()
        drawMediumMaze()
        checkWin()
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        if mediumGameEnded {return}
        slideDown()
        drawMediumMaze()
        checkWin()
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if mediumGameEnded {return}
        slideLeft()
        drawMediumMaze()
        checkWin()
    }
    
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        if mediumGameEnded {return}
        slideRight()
        drawMediumMaze()
        checkWin()
    }
    
    // each individual slide function
    func slideUp(){
        while !isWall(row: playerRow - 1, col: playerCol) {
            playerRow = playerRow - 1
        }
    }
    
    func slideDown(){
        while !isWall(row: playerRow + 1, col: playerCol) {
            playerRow = playerRow + 1
        }
    }
    func slideLeft(){
        while !isWall(row: playerRow, col: playerCol - 1) {
            playerCol = playerCol - 1
        }
    }
    
    func slideRight(){
        while !isWall(row: playerRow, col: playerCol + 1) {
            playerCol = playerCol + 1
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawMediumMaze()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveCount = 0
        updateMoveCounter()
        
        if let randomMaze = mediumMazes.randomElement() {
                mediumMaze = randomMaze
            }
        
        findStartPosition()
        
        lastPlayerRow = playerRow
        lastPlayerCol = playerCol
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        mazeGameMediumModeTimer.text = String(format: "%02d:%02d", minutes, seconds)

    }
    
    func updateMoveCounter() {
        mazeGameMediumModeMoveCounter.text = "Moves: \(moveCount)"
    }
    
    func resetGame() {
        // reset game state
        mediumGameEnded = false
        
        // reset player position
        findStartPosition()
        
        // reset move counter
        moveCount = 0
        updateMoveCounter()
        
        // reset last position tracking (important for your move detection)
        lastPlayerRow = playerRow
        lastPlayerCol = playerCol
        
        // reset timer
        timer?.invalidate()
        timerCount = 0
        mazeGameMediumModeTimer.text = "00:00"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        // redraw maze
        drawMediumMaze()
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

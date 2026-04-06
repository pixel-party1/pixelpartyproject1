//
//  MazeGameEasyModeViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameEasyModeViewController: UIViewController {

    // adding the buttons or links needed
    @IBAction func easyModeButtonTapped(_ sender: Any) {dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var easyMazeBoardView: UIView!
    
    //maze definition (to be changed when logic is finished)
    let easyMaze = [
        "#######",
        "#S.#.G#",
        "#..#..#",
        "#..#..#",
        "#.....#",
        "#...#.#",
        "#...#.#",
        "#######",
    ]
    
    // player position variables
    var playerRow = 0
    var playerCol = 0
    
    //find start position (where it says S on maze)
    func findStartPosition() {
        for row in 0..<easyMaze.count {
            let currentRow = Array(easyMaze[row])
            
            for col in 0..<currentRow.count {
                if currentRow[col] == "S" {
                    playerRow = row
                    playerCol = col
                    return
                }
            }
        }
    }
    
   // maze drawing function
    func drawEasyMaze() {
        easyMazeBoardView.subviews.forEach({$0.removeFromSuperview()})
        
        let rows = easyMaze.count
        let cols = easyMaze[0].count
        
        // makes the frame more square
        let tileSize = min(easyMazeBoardView.bounds.width / CGFloat(cols), easyMazeBoardView.bounds.height / CGFloat(rows))
        
        let totalWidth = tileSize * CGFloat(cols)
        let totalHeight = tileSize * CGFloat(rows)
        
        let xOffset = (easyMazeBoardView.bounds.width - totalWidth) / 2
        let yOffset = (easyMazeBoardView.bounds.height - totalHeight) / 2
        
        for row in 0..<rows {
            let currentRow = Array(easyMaze[row])
            
            for col in 0..<cols {
                let x = xOffset + CGFloat(col) * tileSize
                let y = yOffset + CGFloat(row) * tileSize
                
                let tileView = UIView(frame: CGRect(x: x, y: y, width: tileSize, height: tileSize))
                
                let character = currentRow[col]
                if character == "#"{
                    tileView.backgroundColor = .black
                } else if character == "G"{
                    tileView.backgroundColor = .yellow
                } else {
                    tileView.backgroundColor = .lightGray
                }
                
                tileView.layer.borderWidth = 1
                tileView.layer.borderColor = UIColor.black.cgColor
                
                easyMazeBoardView.addSubview(tileView)
            }
        }
        
        let playerX = xOffset + CGFloat(playerCol) * tileSize + 5
        let playerY = yOffset + CGFloat(playerRow) * tileSize + 5
        
        let playerView = UIView(frame: CGRect(x: playerX, y: playerY, width: tileSize - 10, height: tileSize - 10))
        playerView.backgroundColor = .systemBlue
        playerView.layer.cornerRadius = min(tileSize - 10, tileSize - 10) / 2
        
        easyMazeBoardView.addSubview(playerView)
    }
    //swiping gesture recognistion
    func setupSwipeGestures() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    //checking if the player ran into a wall
    func isWall(row: Int, col: Int) -> Bool{
        if row < 0 || row >= easyMaze.count{
            return true
        }
        
        let currentRow = Array(easyMaze[row])
        
        if col < 0 || col >= currentRow.count {
            return true
        }
        
        return currentRow[col] == "#"
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
    
    // actually seeing if the player has reached the goal
    func checkWin() {
        let currentRow = Array(easyMaze[playerRow])
        let character = currentRow[playerCol]
        
        if character == "G"{
            let alert = UIAlertController(title: "YOU WIN!!", message: "Easy Maze complete", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .up:
            slideUp()
        case .down:
            slideDown()
        case .left:
            slideLeft()
        case .right:
            slideRight()
        default :
            return
        }
        drawEasyMaze()
        checkWin()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawEasyMaze()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //function to find the start position
        findStartPosition()
        //main game logic
        setupSwipeGestures()
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


//
//  SlidingPuzzleViewController.swift
//  pixel party
//
//  Created by Roome, Ellis on 18/03/2026.
//

import UIKit

class SlidingPuzzleViewController: UIViewController {
    
    
    @IBAction func solveTapped(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        board.tiles = Array(1..<(board.size * board.size)) + [0]
        boardView.refresh(board: board)
        showWinAlert()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var boardContainerView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!

    // MARK: - Properties
    private var board = PuzzleBoard(size: 3)
    private var boardView = BoardView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        startGame(size: 3) // default to Easy on first load
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // boardContainerView's final size isn't known until layout is complete,
        // so we size the boardView here rather than in viewDidLoad

    }

    // MARK: - Game Logic
    private func startGame(size: Int) {
        board = PuzzleBoard(size: size)
        board.imageName = "puzzle_image.jpg"
        board.shuffle(steps: shuffleSteps(for: size))
        updateMovesLabel()
        buildBoardView()
        updateUndoRedoButtons()
    }

    private func buildBoardView() {
        boardView.removeFromSuperview()
        boardView = BoardView()
        boardView.frame = boardContainerView.bounds
        boardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        boardContainerView.addSubview(boardView)
        boardView.setNeedsLayout()
        boardView.layoutIfNeeded()
        boardView.setup(board: board)

        boardView.onMove = { [weak self] index in
            self?.handleMove(at: index)
        }
    }

    private func handleMove(at index: Int) {
        // Save state before moving so undo works
        board.saveStateForUndo(limit: 3)

        let moved = board.moveTile(at: index)

        if moved {
            boardView.refresh(board: board)
            updateMovesLabel()
            updateUndoRedoButtons()
            if board.isSolved { showWinAlert() }
        } else {
            // Move was invalid — remove the snapshot just saved
            board.undoStack.removeLast()
        }
    }

    private func shuffleSteps(for size: Int) -> Int {
        switch size {
        case 3:  return 50
        case 4:  return 100
        default: return 200
        }
    }

    // MARK: - Undo / Redo
    @IBAction func undoTapped(_ sender: Any) {
        if board.undo() {
            boardView.refresh(board: board)
            updateUndoRedoButtons()
        }
    }

    @IBAction func redoTapped(_ sender: Any) {
        if board.redo() {
            boardView.refresh(board: board)
            updateUndoRedoButtons()
        }
    }

    private func updateUndoRedoButtons() {
        // Grey out buttons when there is nothing left to undo or redo
        undoButton.isEnabled = !board.undoStack.isEmpty
        redoButton.isEnabled = !board.redoStack.isEmpty
    }

    // MARK: - Actions
    @IBAction func homeTapped(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func shuffleTapped(_ sender: Any) {
        startGame(size: board.size)
    }

    @IBAction func difficultyChanged(_ sender: UISegmentedControl) {
        let sizes = [3, 4, 6]
        let size  = sizes[sender.selectedSegmentIndex]
        startGame(size: size)
    }

    // MARK: - Labels
    private func updateMovesLabel() {
        movesLabel.text = "Moves: \(board.moveCount)"
        movesLabel.font = UIFont(name: "Kenney-Rocket", size: 20)
    }

    // MARK: - Win
    private func showWinAlert() {
        AudioManager.shared.playWin()
        let alert = UIAlertController(
            title: "Solved!",
            message: "You completed the puzzle in \(board.moveCount) moves.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Play Again", style: .default) { [weak self] _ in
            guard let self else { return }
            self.startGame(size: self.board.size)
        })
        alert.addAction(UIAlertAction(title: "Home", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
}

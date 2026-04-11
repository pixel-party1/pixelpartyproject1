//
//  MemoryMatchMediumModeViewController.swift
//  pixel party
//
//
import UIKit

class MemoryMatchMediumModeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    // MARK: - Game Data
    var cards: [MemoryCard] = []
    var firstFlippedIndex: IndexPath?
    var moves = 0
    var matchedPairs = 0
    var isChecking = false

    // MARK: - Timer
    var seconds = 0
    var timer: Timer?

    // Medium mode = 4x5 grid = 10 pairs
    let totalPairs = 10

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        setupCards()
        startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    // MARK: - Card Setup
    func setupCards() {
        // 10 image names for 10 pairs
        let imageNames = ["card1", "card2", "card3", "card4", "card5",
                          "card6", "card7", "card8", "card9", "card10"]

        var deck: [MemoryCard] = []

        for (index, name) in imageNames.enumerated() {
            let card1 = MemoryCard(cardID: index, imageName: name, isFlipped: false, isMatched: false)
            let card2 = MemoryCard(cardID: index, imageName: name, isFlipped: false, isMatched: false)
            deck.append(card1)
            deck.append(card2)
        }

        cards = deck.shuffled()

        moves = 0
        matchedPairs = 0
        movesLabel.text = "Moves: 0"
    }

    // MARK: - Timer
    func startTimer() {
        seconds = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.seconds += 1
            self.timeLabel.text = "Time: \(self.seconds)s"
        }
    }

    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        let card = cards[indexPath.item]

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        if card.isFlipped || card.isMatched {
            imageView.image = UIImage(named: card.imageName)
            cell.contentView.backgroundColor = .white
        } else {
            imageView.image = UIImage(named: "cardBack")
            cell.contentView.backgroundColor = UIColor.systemIndigo
        }

        cell.contentView.addSubview(imageView)
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.clipsToBounds = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if isChecking { return }
        if cards[indexPath.item].isMatched { return }
        if cards[indexPath.item].isFlipped { return }

        cards[indexPath.item].isFlipped = true
        flipCard(at: indexPath)

        if firstFlippedIndex == nil {
            firstFlippedIndex = indexPath
        } else {
            checkForMatch(secondIndex: indexPath)
        }
    }

    // MARK: - Flip Animation
    func flipCard(at indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        UIView.transition(with: cell.contentView,
                          duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: {
            self.collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }

    // MARK: - Match Check
    func checkForMatch(secondIndex: IndexPath) {
        guard let firstIndex = firstFlippedIndex else { return }

        isChecking = true
        moves += 1
        movesLabel.text = "Moves: \(moves)"

        let firstCard = cards[firstIndex.item]
        let secondCard = cards[secondIndex.item]

        if firstCard.cardID == secondCard.cardID {
            cards[firstIndex.item].isMatched = true
            cards[secondIndex.item].isMatched = true
            matchedPairs += 1
            firstFlippedIndex = nil
            isChecking = false

            if matchedPairs == totalPairs {
                timer?.invalidate()
                showWinAlert()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.cards[firstIndex.item].isFlipped = false
                self.cards[secondIndex.item].isFlipped = false
                self.collectionView.reloadItems(at: [firstIndex, secondIndex])
                self.firstFlippedIndex = nil
                self.isChecking = false
            }
        }
    }

    // MARK: - Win
    func showWinAlert() {
        let alert = UIAlertController(title: "You Win! 🎉",
                                      message: "Moves: \(moves)\nTime: \(seconds)s",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.setupCards()
            self.collectionView.reloadData()
            self.startTimer()
        }))

        alert.addAction(UIAlertAction(title: "Back to Menu", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))

        present(alert, animated: true, completion: nil)
    }

    // MARK: - Back Button
    @IBAction func memoryMatchMediumModeBackButtonPressed(_ sender: UIButton) {
        timer?.invalidate()
        dismiss(animated: true, completion: nil)
    }
}

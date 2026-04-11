//
//  MemoryCard.swift
//  pixel party
//

import Foundation

struct MemoryCard {
    let cardID: Int         // unique ID for each card (1, 2, 3...)
    let imageName: String   // name of the image asset
    var isFlipped: Bool     // is the card face up?
    var isMatched: Bool     // has this card been matched?
}

//
//  Fractiles.swift
//  1-qualification-round
//
//  Created by gurren-l on 2017. 4. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

enum Tile: Character {
    case gold = "0"
    case lead = "1"
}

class Artwork {
    
    let base: Array<Tile>
    let tiles: Array<Tile>
    
    convenience init(number: Int, tileCount: Int) {
        let binaryText = String(number, radix: 2)
        var zeroPadding = ""
        for _ in 0 ..< tileCount - binaryText.characters.count {
            zeroPadding.append("0")
        }
        let tiles = "\(zeroPadding)\(binaryText)".characters.flatMap({ Tile(rawValue: $0) })
        self.init(base: tiles, tiles: tiles)
    }
    
    init(base: Array<Tile>, tiles: Array<Tile>) {
        self.base = base
        self.tiles = tiles
    }
    
    func complexify() -> Artwork {
        var complexifiedTiles = Array<Tile>()
        self.tiles.forEach({
            switch $0 {
            case .gold:
                complexifiedTiles.append(contentsOf: Array<Tile>(repeating: .gold, count: self.base.count))
            case .lead:
                complexifiedTiles.append(contentsOf: self.base)
            }
        })
        return Artwork(base: self.base, tiles: complexifiedTiles)
    }
    
    func printTiles() {
        let characters: Array<Character> = self.tiles.map({
            switch $0 {
            case .gold:
                return "G"
            case .lead:
                return "L"
            }
        })
        print("\(String(characters))")
    }
    
}

class Fractiles {
    
    let tileCount: Int
    let complexity: Int
    
    
    init(input: String) {
        let inputs = input.components(separatedBy: " ").flatMap({ Int($0) })
        self.tileCount = inputs[0]
        self.complexity = inputs[1]
    }
    
    func output() -> String {
        var possibleArtworks = Array<Artwork>()
        for number in 0 ..< Int(pow(Double(2), Double(self.tileCount))) {
            var artwork = Artwork(number: number, tileCount: self.tileCount)
            for _ in 1 ..< self.complexity {
                artwork = artwork.complexify()
            }
            possibleArtworks.append(artwork)
        }
        possibleArtworks.forEach({ $0.printTiles() })
        return "2"
    }
}

//
//  Fractiles.swift
//  1-qualification-round
//
//  Created by gurren-l on 2017. 4. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

enum Tile: Character {
    case gold = "G"
    case lead = "L"
}

class Artwork {
    
    let base: Array<Tile>
    var tiles: Array<Tile>
    
    convenience init(tileCount: Int) {
        let tiles = Array<Tile>(repeating: .gold, count: tileCount)
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
    
    func increment() -> Bool {
        for index in (0 ..< self.tiles.count).reversed() {
            if case .gold = self.tiles[index] {
                self.tiles[index] = .lead
                return true
            } else if case .lead = self.tiles[index] {
                self.tiles[index] = .gold
            }
        }
        return false
    }
    
    func printTiles() {
        print("\(String(self.tiles.map({ $0.rawValue })))")
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
        let base = Artwork(tileCount: self.tileCount)
        var possibleArtworks = Array<Artwork>()
        repeat {
            var artwork = Artwork(base: base.tiles, tiles: base.tiles)
            for _ in 1 ..< self.complexity {
                artwork = artwork.complexify()
            }
            possibleArtworks.append(artwork)
        } while base.increment()
        possibleArtworks.forEach({ $0.printTiles() })
        return "2"
    }
    
}

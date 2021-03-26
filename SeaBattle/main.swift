//
//  main.swift
//  SeaBattle
//
//  Created by Henly Harrold on 3/26/21.
//  Copyright © 2021 ___School21___. All rights reserved.
//


import Foundation



class Player {
    var map = Map()
    var enemyMap = Map()

    init() {
        RandomFillMap()
    }

    func ModifiedCoordinate(y: inout Int, x: inout Int) {
        if x > 9 {
            x = 0
            y -= 1
        }
        if x < 0 {
            x = 9
            y += 1
        }
        if y > 9 {
            y = 0
            x = (x < 9) ? (x + 1) : 0
        }
        if y < 0 {
            y = 9
            x = (x > 0) ? (x - 1) : 0
        }
    }

    func isBadCoordinate(y: Int, x: Int) -> Bool {
        return (x < 0) || (x > 9) || (y < 0) || (y > 9)
    }
    func PlaceRandomShip(shipNumber: Int, ship: Int) {
        var coordX = Int.random(in: 0..<10)
        var coordY = Int.random(in: 0..<10)
        var tempCoordX = coordX
        var tempCoordY = coordY
        let isVertical = (Int.random(in: 0..<2) == 1)
        var i = 0

        while i < ship {
            if isBadCoordinate(y: coordY, x: coordX) {
                ModifiedCoordinate(y: &coordY, x: &coordX)
                i = 0
                tempCoordX = coordX
                tempCoordY = coordY
            }
            if self.map.field[coordY][coordX] != 0 {
                coordX += 1
                i = 0
                tempCoordX = coordX
                tempCoordY = coordY
            } else {
                if isVertical {
                    coordY -= 1
                } else {
                    coordX += 1
                }
                i += 1
            }
        }
        PutShip(y: tempCoordY, x: tempCoordX, isVertical: isVertical, shipNumber: shipNumber, ship: ship)
    }
    func PutTempSimbol(y: Int, x: Int)
    {
        for j in -1...1 {
            for i in -1...1 {
                let coordY = y + j
                let coordX = x + i
                if !isBadCoordinate(y: coordY, x: coordX) {
                    if self.map.field[coordY][coordX] == 0 {
                        self.map.field[coordY][coordX] = -1
                    }
                }
            }
        }
    }
    func PutShip(y: Int, x: Int, isVertical: Bool, shipNumber: Int, ship: Int) {
        var coordY = y
        var coordX = x
        for var i in 0..<ship {
            self.map.field[coordY][coordX] = shipNumber
            PutTempSimbol(y: coordY, x: coordX)
            if isVertical {
                coordY -= 1
            } else {
                coordX += 1
            }
        }
    }

    func ClearTempSimbol() {
        for coordY in 0..<10 {
            for coordX in 0..<10 {
                if self.map.field[coordY][coordX] < 0 {
                    self.map.field[coordY][coordX] = 0
                }
            }
        }
    }

    func RandomFillMap() {

        var shipNumber = 1
        for ship in self.map.ships {
            PlaceRandomShip(shipNumber: shipNumber, ship: ship)
            shipNumber += 1
        }
        ClearTempSimbol()
    }

}

class Game {

    var player1 = Player()
    var player2 = Player()
    let coordX = "abcdefghij"
    let coordY = 10

    private func GetSimbol(ch: Int) -> SimbolMap {
        switch(ch) {
        case 1...10:
            return .Ship
        case 0:
            return .Terra
        case -1:
            return .Miss
        case -2:
            return .Empty
        case -3:
            return .Hit
        default:
            return .Error
        }
    }

    private func printDot<T>(ch: T)
    {
        if let ch = ch as? Int {
            print("\(GetSimbol(ch: ch).rawValue)", terminator: "")
        } else {
            print("\(ch)", terminator: "")
        }
    }

    private func printLine<T>(line: Array<T>)
    {
        for var ch in line {
            printDot(ch: ch)
            print(" ", terminator: "")
        }
    }
    
    private func printBlock(j: Int,line: Array<Int>)
    {
        if j == 0 {
            print("   ", terminator: "")
            printLine(line: Array<Character>(coordX))
        } else {
            if j < 10{
                print(" ", terminator: "")
            }
            print(j, terminator: "")
            print(" ", terminator: "")

            printLine(line: line)
        }
    }

    public func printMap() {
        for var j in 0...coordY {
            printBlock(j: j, line: self.player1.map.field[j == 0 ? 0 : (j - 1)])
            print("\t\t", terminator: "")
            printBlock(j: j, line: self.player1.enemyMap.field[j == 0 ? 0 : (j - 1)])
            print()
        }
    }
}

let game = Game()
game.printMap()

//
// Created by Henly Harrold on 3/26/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

struct Map {

    private var field = Array(repeating:([Int](repeating: 0, count: 10)), count: 10)

    private var ships: [Int] = [4,3,3,2,2,2,1,1,1,1]

    public func isBadCoordinate(y: Int, x: Int) -> Bool {
        (x < 0) || (x > 9) || (y < 0) || (y > 9)
    }

    func GetField() -> Array<[Int]> {
        field
    }
    func GetShips() -> [Int] {
        ships
    }

    var isAnyShip : Bool {
        for i in ships {
            if i > 0 {
                return true
            }
        }
        return false
    }

    func GetFieldPoint(coordY: Int, coordX: Int) -> Int {
        return  self.field[coordY][coordX]
    }

    func GetFieldLine(coordY: Int) -> Array<Int> {
        return  self.field[coordY]
    }

    mutating func SetShips(ship: Int) -> Int {
        if (ship - 1) >= 0 && (ship - 1) < ships.count {
            if self.ships[ship - 1] > 0 {
                self.ships[ship - 1] -= 1
            }
            return self.ships[ship - 1]
        }
        return 0
    }

    mutating func SetFieldPoint(coordY: Int, coordX: Int, value: Int) {
        self.field[coordY][coordX] = value
    }

    mutating func SetVoidField(coordY: Int, coordX: Int, lastCoordY: Int, lastCoordX: Int) {
        if field[coordY][coordX] == SymbolField.Hit.rawValue {
            for j in -1...1 {
                for i in -1...1{
                    if !isBadCoordinate(y: coordY + j, x: coordX + i)
                               && (coordY + j != lastCoordY || coordX + i != lastCoordX) && (j != 0 || i != 0) {
                        SetVoidField(coordY: coordY + j,coordX: coordX + i, lastCoordY: coordY, lastCoordX: coordX)
                    }
                }
            }
        } else if self.field[coordY][coordX] == 0 || self.field[coordY][coordX] == SymbolField.Hit.rawValue{
            self.field[coordY][coordX] = SymbolField.Empty.rawValue
        }
    }
}

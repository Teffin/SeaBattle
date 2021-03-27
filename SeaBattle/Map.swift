//
// Created by Henly Harrold on 3/26/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

struct Map {
        private var field: Array<Array<Int>> = [[0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0],
                                                [0,0,0,0,0,0,0,0,0,0]]

    private var ships: Array<Int> = [4,3,3,2,2,2,1,1,1,1]

    func isBadCoordinate(y: Int, x: Int) -> Bool {
        (x < 0) || (x > 9) || (y < 0) || (y > 9)
    }

    func GetShips() -> Array<Int> {
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
        self.ships[ship - 1] -= 1
        return self.ships[ship - 1]
    }

    mutating func SetFieldPoint(coordY: Int, coordX: Int, value: Int) {
        self.field[coordY][coordX] = value
    }

    mutating func SetVoidField(coordY: Int, coordX: Int) {
        if field[coordY][coordX] == -3 {
            SetFieldPoint(coordY: coordY, coordX: coordX, value: -4)
            for j in -1...1 {
                for i in -1...1{
                    if !isBadCoordinate(y: coordY + j, x: coordX + i) && j + i != 0 {
                        SetVoidField(coordY: coordY + j,coordX: coordX + i)
                    }
                }
            }
        } else if self.field[coordY][coordX] != -3 && self.field[coordY][coordX] != -4 {
            SetFieldPoint(coordY: coordY, coordX: coordX, value: -2)
        }
    }
}

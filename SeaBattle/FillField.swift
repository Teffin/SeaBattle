//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class FillField: Filler {
    private var map = Map()

    init() { }

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
        (x < 0) || (x > 9) || (y < 0) || (y > 9)
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
            if self.map.GetFieldPoint(coordY: coordY, coordX: coordX) != 0 {
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

    func PutTempSymbol(y: Int, x: Int)
    {
        for j in -1...1 {
            for i in -1...1 {
                let coordY = y + j
                let coordX = x + i
                if !isBadCoordinate(y: coordY, x: coordX) {
                    if self.map.GetFieldPoint(coordY: coordY, coordX: coordX) == 0 {
                        self.map.SetFieldPoint(coordY: coordY, coordX: coordX, value: -1)
                    }
                }
            }
        }
    }

    func PutShip(y: Int, x: Int, isVertical: Bool, shipNumber: Int, ship: Int) {
        var coordY = y
        var coordX = x

        for _ in 0..<ship {
            self.map.SetFieldPoint(coordY: coordY, coordX: coordX, value: shipNumber)
            PutTempSymbol(y: coordY, x: coordX)
            if isVertical {
                coordY -= 1
            } else {
                coordX += 1
            }
        }
    }

    func ClearTempSymbol() {
        for coordY in 0..<10 {
            for coordX in 0..<10 {
                if self.map.GetFieldPoint(coordY: coordY, coordX: coordX) < 0 {
                    self.map.SetFieldPoint(coordY: coordY, coordX: coordX, value: 0)
                }
            }
        }
    }

    public func RandomFillMap() -> Map {
        var shipNumber = 1

        for ship in self.map.GetShips() {
            PlaceRandomShip(shipNumber: shipNumber, ship: ship)
            shipNumber += 1
        }
        ClearTempSymbol()
        return self.map
    }

    public func ManualFillMap() -> Map {

        let inputCoordText = ", please input Coordinate: "
        let verticalText = "Do you want place your ship vertical? (y/n):"

        var shipNumber = 1

        for ship in self.map.GetShips() {
            var coordX: Int = 0
            var coordY: Int = 0
            var isValidInput: Bool = false
            var isCanPlace: Bool = false
            var isVertical: Bool = false
            while !isCanPlace {
                while !isValidInput {
                    print("We place \(ship) deck's ship \(inputCoordText)", terminator: "")
                    let input = InputPlayer.ConsoleInput()
                    (isValidInput, coordX, coordY) = Validate.ValidateInput(input: input)
                    // ValidateInput(input)
                }
                isValidInput = false
                while !isValidInput {
                    print(verticalText, terminator: "")
                    let input = InputPlayer.ConsoleInput()
                    (isValidInput, isVertical) = Validate.ValidateConfirmation(input: input)
                }
                //TODO CanPlace??
                isCanPlace = true
            }
            PutShip(y: coordY, x: coordX, isVertical: isVertical, shipNumber: shipNumber, ship: ship)
            shipNumber += 1
        }
        ClearTempSymbol()
        return self.map
    }
}


//func FillMap(isAuto: Bool = true) -> Map {
//    var coordX: Int = 0
//    var coordY: Int = 0
//    var isVertical: Bool = false
//    var shipNumber = 1
//
//    for ship in self.map.GetShips() {
//        if isAuto {
//            coordX = Int.random(in: 0..<10)
//            coordY = Int.random(in: 0..<10)
//            isVertical = (Int.random(in: 0..<2) == 1)
//        } else {
//            for str in getMap() {
//                print(str)
//            }
//            print("We place \(ship) deck's ship \(inputCoordText)", terminator: "")
//            var isValidInput = false
//            while !isValidInput {
//                var input = readLine()
//                input = input?.lowercased()
//                input = String(input!.filter { !" \n\t\r".contains($0) })
//                (isValidInput, coordX, coordY) = Validate.ValidateAndParseInput(input: input)
//            }
//            print(inputVerticalText, terminator: "")
//            isValidInput = false
//            while !isValidInput {
//                var input = readLine()
//                input = input?.lowercased()
//                input = String(input!.filter { !" \n\t\r".contains($0) })
//                (isValidInput, isVertical) = Validate.ValidateConfirmation(input: input)
//            }
//
//        }
//        SearchPlaceShip(shipNumber: shipNumber, ship: ship, X: coordX, Y: coordY, isVertical: isVertical)
//
//        shipNumber += 1
//    }
//    ClearTempSymbol()
//    return self.map
//}
//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class AIStepper: Stepper {

    func ScanMap(map: Map) -> (Bool, Int, Int) {
        let field = map.GetField()
        for coordY in 0..<field.count {
            for coordX in 0..<field[coordY].count {
                if field[coordY][coordX] == SymbolField.Ship.rawValue {
                    return (true, coordY, coordX)
                }
            }
        }
        return (false, 0, 0)
    }

    public func GetCoordinate(map: Map) -> (coordY: Int, coordX: Int) {
        var row: Int
        var line: Int
        var isShip: Bool

        (isShip, line, row ) = ScanMap(map: map)
        if !isShip {
            row = Int.random(in: 0..<10)
            line = Int.random(in: 0..<10)
            while map.GetFieldPoint(coordY: line, coordX: row) < 0 {
                row = Int.random(in: 0..<10)
                line = Int.random(in: 0..<10)
            }
        }
        return (line, row)
    }

    func CheckAroundShot(map: Map, coordY: Int, coordX: Int) -> Bool {
        let field = map.GetField()
        for j in -1...1 {
            for i in -1...1 {
                if !map.isBadCoordinate(y: coordY + j, x: coordX + i)
                           && (field[coordY + j][coordX + i] == SymbolField.Hit.rawValue)
                           && (abs(j) != abs(i)) {
                    return true
                }
            }
        }
        return false
    }

    func ClearHelpField(map: inout Map, coordY: Int, coordX: Int, lastCoordY: Int, lastCoordX: Int) {
        let field = map.GetField()
        if field[coordY][coordX] == SymbolField.Hit.rawValue {
            for j in -1...1 {
                for i in -1...1 {
                    if !map.isBadCoordinate(y: coordY + j, x: coordX + i)
                               && (field[coordY + j][coordX + i] == SymbolField.Ship.rawValue) {
                        map.SetFieldPoint(coordY: coordY + j, coordX: coordX + i, value: SymbolField.Terra.rawValue)
                    } else if !map.isBadCoordinate(y: coordY + j, x: coordX + i)
                    && (field[coordY + j][coordX + i] == SymbolField.Hit.rawValue)
                            && (abs(j) != abs(i))
                            && ((coordY + j != lastCoordY)
                            || (coordX + i != lastCoordX)) {
                        ClearHelpField(map: &map, coordY: coordY + j,
                                coordX: coordX + i, lastCoordY: coordY, lastCoordX: coordX)
                    }
                }
            }
        }
    }

    func PasteHelpFieldIfKnowVector(map: inout Map, coordY: Int, coordX: Int) {
        let field = map.GetField()
        var y: Int
        var x: Int
        y = 0
        x = 0
        for j in -1...1 {
            for i in -1...1 {
                if !map.isBadCoordinate(y: coordY + j, x: coordX + i)
                           && (field[coordY + j][coordX + i] == SymbolField.Hit.rawValue) && (abs(j) != abs(i)) {
                    y = j
                    x = i
                }
            }
        }
        var tempX: Int
        var tempY: Int
        tempX = 0
        tempY = 0
        while (x != y)
                      && !map.isBadCoordinate(y: coordY + tempY, x: coordX + tempX)
                      && field[coordY + tempY][coordX + tempX] == SymbolField.Hit.rawValue {
            tempX += x
            tempY += y
        }
        if !map.isBadCoordinate(y: coordY + tempY, x: coordX + tempX)
                   && field[coordY + tempY][coordX + tempX] == SymbolField.Terra.rawValue {
            map.SetFieldPoint(coordY: coordY + tempY, coordX: coordX + tempX, value: SymbolField.Ship.rawValue)
        }
        tempX -= x
        tempY -= y
        while (x != y)
                      && !map.isBadCoordinate(y: coordY + tempY, x: coordX + tempX)
                      && field[coordY + tempY][coordX + tempX] == SymbolField.Hit.rawValue {
            tempX -= x
            tempY -= y

        }
        if !map.isBadCoordinate(y: coordY + tempY, x: coordX + tempX)
                   && field[coordY + tempY][coordX + tempX] == SymbolField.Terra.rawValue {
            map.SetFieldPoint(coordY: coordY + tempY, coordX: coordX + tempX, value: SymbolField.Ship.rawValue)
        }
    }

    func PasteHelpField(map: inout Map, coordY: Int, coordX: Int) {
        let field = map.GetField()
        for j in -1...1 {
            for i in -1...1 {
                if !map.isBadCoordinate(y: coordY + j, x: coordX + i)
                           && (field[coordY + j][coordX + i] == SymbolField.Terra.rawValue)
                           && (abs(j) != abs(i)) {
                    map.SetFieldPoint(coordY: coordY + j, coordX: coordX + i, value: SymbolField.Ship.rawValue)
                }
            }
        }
    }
    func SetHelpPoint(map: inout Map, coordY: Int, coordX: Int) {
        if CheckAroundShot(map: map, coordY: coordY, coordX: coordX) {
            ClearHelpField(map: &map, coordY: coordY, coordX: coordX, lastCoordY: coordY, lastCoordX: coordX)
            PasteHelpFieldIfKnowVector(map: &map, coordY: coordY, coordX: coordX)
        } else {
            PasteHelpField(map: &map, coordY: coordY, coordX: coordX)
        }
    }

    public func SetField(sameMap: inout Map, coordY: Int, coordX: Int, value: Int, kill: Bool) {
        sameMap.SetFieldPoint(coordY: coordY, coordX: coordX, value: value)
        if kill {
            sameMap.SetVoidField(coordY: coordY, coordX: coordX, lastCoordY: coordY, lastCoordX: coordX)
        } else if value == SymbolField.Hit.rawValue {
            SetHelpPoint(map: &sameMap, coordY: coordY, coordX: coordX)
        }
    }
}
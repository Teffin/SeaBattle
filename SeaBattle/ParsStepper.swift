//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class ParsStepper: Stepper {

    func ValidateAndParseCharacter(character: Character) -> Int {
        let letters  = "abcdefghij"
        var count = 0

        for ch in letters {
            if ch == character {
                return count
            }
            count += 1
        }
        return -1
    }

    func ValidateAndParseInput(input: String?) -> (Bool, Int, Int) {

        if input != "" {
            let count = input?.count
            let str = Array(input ?? "")
            if  count == 2 {
                let coordY = ValidateAndParseCharacter(character: str[0])
                if coordY == -1 {
                    return (false, 0, 0)
                }
                if str[1] <= "9" && str[1] > "0" {
                    return(true, coordY, Int(String(str[1]))! - 1)
                }
            } else if count == 3 {
                let coordY = ValidateAndParseCharacter(character: str[0])
                if coordY == -1 {
                    return (false, 0, 0)
                }
                if str[1] == "1" && str[2] == "0" {
                    return (true, coordY, 9)
                }
            }
        }
        return (false, 0, 0)
    }

    func GetCoordinate(map: Map) -> (coordY: Int, coordX: Int) {
        var row = 0
        var line = 0
        let field = map.GetField()
        var isValidCoordinate = false

        while !isValidCoordinate {
            print("Input coordinate: ", terminator: "")
            var input = readLine()
            input = input?.lowercased()
            input = String(input!.filter { !" \n\t\r".contains($0) })
            (isValidCoordinate, line, row) = ValidateAndParseInput(input: input)
            if !isValidCoordinate {
                print("Coordinate is not correct! For Example : g 5")
            } else if field[row][line] < 0 {
                print("Attack this coordinate is not reason, please choose another Point!")
                isValidCoordinate = false
            }
        }
        return (row, line)
    }

    func SetField(sameMap: inout Map, coordY: Int, coordX: Int, value: Int, kill: Bool) {
        sameMap.SetFieldPoint(coordY: coordY, coordX: coordX, value: value)
        if kill {
            sameMap.SetVoidField(coordY: coordY, coordX: coordX, lastCoordY: coordY, lastCoordX: coordX)
        }
    }
}

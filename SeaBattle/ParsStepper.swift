//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class ParsStepper: Stepper {

    let unCorrectCoordinateText = "Coordinate is not correct! For Example : g 5"
    let missCoordinateText = "Attack this coordinate is not reason, please choose another Point!"
    let inputText = "Input coordinate: "

    func GetCoordinate(map: Map) -> (coordY: Int, coordX: Int) {
        var row = 0
        var line = 0
        let field = map.GetField()
        var isValidCoordinate = false

        while !isValidCoordinate {
            print(inputText, terminator: "")
            var input = readLine()
            input = input?.lowercased()
            input = String(input!.filter { !" \n\t\r".contains($0) })
            (isValidCoordinate, line, row) = Validate.ValidateInput(input: input)
            if !isValidCoordinate {
                print(unCorrectCoordinateText)
            } else if field[row][line] < 0 {
                print(missCoordinateText)
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

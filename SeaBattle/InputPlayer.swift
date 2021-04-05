//
// Created by Henly Harrold on 4/2/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class InputPlayer {

    static let inputText = "Input number for choose: "
    static let anyKeyText = "Press Enter to continue..."
    static let somethingWrong = "SomeThingWrong"

    init() {

    }

    static func ValidateInput(input: String?) -> (Bool, Int) {
        if input != "" {
            let count = input?.count
            let str = Array(input ?? "")
            if  count == 1 {
                if str[0] <= "3" && str[0] > "0" {
                    return(true, Int(String(str[0]))!)
                }
            }
        }
        return(false, 0)
    }

    static func GetCase() -> Int {
        var isValidInput = false
        var parsedNum = 0

        while !isValidInput {
            print(inputText, terminator: "")
            var input = readLine()
            input = input?.lowercased()
            input = String(input!.filter { !" \n\t\r".contains($0) })
            (isValidInput, parsedNum) = ValidateInput(input: input)
        }
        return parsedNum
    }

    static func PrintAndWaitAnyKey() {
        print(anyKeyText, terminator: "")
        _ = readLine()
    }

    static func PrintError() {
        print(somethingWrong)
    }

    static func ParsePlayerInput(menu: Menu) -> Menu {
        var parsedNumForMenu = 0

        switch(menu) {
        case .mainMenu:
            parsedNumForMenu = GetCase()
        case .startMatch:
            PrintAndWaitAnyKey()
            return .mainMenu
        case .settings:
            return .mainMenu
        case .quitGame:
            PrintError()
            exit(1)
        }

        switch(parsedNumForMenu) {
        case 1:
            return .startMatch
        case 2:
            return .settings
        case 3:
            return .quitGame
        default:
            return .mainMenu
        }
    }
}

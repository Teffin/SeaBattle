//
// Created by Henly Harrold on 4/2/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class InputPlayer {

    static let inputText = "Input number for choose: "
    static let anyKeyText = "Press Enter to continue..."
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

    static func ParsePlayerInput(menu: Menu) -> Menu {
        var isValidInput = false
        var parsedNum = 0
        if menu == Menu.startMatch {
            print(anyKeyText, terminator: "")
            readLine()
            return .mainMenu
        }
        while !isValidInput {
            print(inputText, terminator: "")
            var input = readLine()
            input = input?.lowercased()
            input = String(input!.filter { !" \n\t\r".contains($0) })
            (isValidInput, parsedNum) = ValidateInput(input: input)
        }
        switch(parsedNum) {
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

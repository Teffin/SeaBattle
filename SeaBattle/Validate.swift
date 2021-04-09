//
// Created by Henly Harrold on 4/5/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class Validate {

    static func ValidateCharacter(character: Character) -> Int {
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

    public static func ValidateConfirmation(input: String?) -> (Bool, Bool) {
        if input != "" {
            let count = input?.count
            let str = Array(input ?? "")
            if  count == 1 {
                if str[0] == "y"  {
                    return(true, true)
                } else if str[0] == "n" {
                    return(true, false)
                }
            }
        }
        return (false, false)
    }
    
    public static func ValidateInput(input: String?) -> (Bool, Int, Int) {

        if input != "" {
            let count = input?.count
            let str = Array(input ?? "")
            if  count == 2 {
                let coordY = ValidateCharacter(character: str[0])
                if coordY == -1 {
                    return (false, 0, 0)
                }
                if str[1] <= "9" && str[1] > "0" {
                    return(true, coordY, Int(String(str[1]))! - 1)
                }
            } else if count == 3 {
                let coordY = ValidateCharacter(character: str[0])
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
}

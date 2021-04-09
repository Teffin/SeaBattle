//
// Created by Henly Harrold on 4/9/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class ConsoleInput {
    public static func ParseInput(textToPrint: String) -> String? {
        print(textToPrint, terminator: "")
        var input = readLine()
        input = input?.lowercased()
        input = String(input?.filter { !" \n\t\r".contains($0)} ?? "")
        return input
    }
}

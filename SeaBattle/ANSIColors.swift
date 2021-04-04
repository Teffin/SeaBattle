//
// Created by Henly Harrold on 4/4/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

enum ANSIColors: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case `default` = "\u{001B}[0;0m"
}

func + (left: ANSIColors, right: String) -> String {
    return left.rawValue + right
}

func GetColourByInt(ch: Int) -> ANSIColors {
    switch (ch) {
    case 1...10:
        return .green
    case 0:
        return .white
    case -1:
        return .black
    case -2:
        return .black
    case -3:
        return .red
    case -4:
        return .red
    default:
        return .`default`
    }
}

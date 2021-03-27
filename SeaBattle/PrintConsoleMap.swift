//
// Created by Henly Harrold on 3/27/21.
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

func GetColour(ch: Int) -> ANSIColors {
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
class PrintConsoleMap : PrinterMap {
    let coordX = "abcdefghij"
    let coordY = 10


    private func printSimbolColour(ch: Int) {
        PrintColour(color: GetColour(ch: ch), text: GetSimbol(ch: ch).rawValue, terminator: "")
    }
    private func printDot<T>(ch: T)
    {
        if let ch = ch as? Int {
            printSimbolColour(ch: ch)
        } else {
            print("\(ch)", terminator: "")
        }
    }

    private func printLine<T>(line: Array<T>)
    {
        for ch in line {
            printDot(ch: ch)
            print(" ", terminator: "")
        }
    }

    private func printBlock(j: Int,line: Array<Int>)
    {
        if j == 0 {
            print("   ", terminator: "")
            printLine(line: Array<Character>(coordX))
        } else {
            if j < 10{
                print(" ", terminator: "")
            }
            print(j, terminator: "")
            print(" ", terminator: "")

            printLine(line: line)
        }
    }

    func PrintColour(color: ANSIColors, text: String, terminator: String = "\n") {
        print(color.rawValue + text + ANSIColors.default.rawValue, terminator: terminator)
    }

    func PrintTitle() {
        PrintColour(color: ANSIColors.green, text: "+ + + YourField + + +  ", terminator: "\t\t")
        PrintColour(color: ANSIColors.red, text: " + + + EnemyField + + + ")
    }
    func PrintBottom() {
        PrintColour(color: ANSIColors.magenta, text: "--------------------------------------------------")
        print()
    }
    public func PrintMap(player: Player) {
        PrintTitle()
        for j in 0...coordY {
            printBlock(j: j, line: player.GetMap().GetFieldLine(coordY: j == 0 ? 0 : (j - 1)))
            print("\t\t", terminator: "")
            printBlock(j: j, line: player.GetEnemyMap().GetFieldLine(coordY: j == 0 ? 0 : (j - 1)))
            print()
        }
        PrintBottom()
    }
    public func AnnouncementOfResults(haveShip: Bool) {
        var color: ANSIColors
        var text: String
        if haveShip {
            color = ANSIColors.green
            text = "Congratulations!!! You Win!!!"
        } else {
            color = ANSIColors.cyan
            text = "So sad, your Lost...Try again - you can do it"
        }
        PrintColour(color: color, text: text)
    }

}

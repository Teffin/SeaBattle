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
class PrintConsoleGame: PrinterGame {
    let winMessage = "Congratulations!!! You Win!!!"
    let loseMessage = "So sad, your Lost...Try again - you can do it"
    let enemyTitle = " + + + EnemyField + + + "
    let yourTitle = " + + + YourField + + +"
    let bottomLine = "--------------------------------------------------"
    let shotShipText = "He shot your ship"
    let missText = "He missed"
    let killText = " and kill"
    let notKillText = ", but not kill"
    let enemyText = "Enemy shot to"
    let coordY = 10
    let coordXLine = Array<Character>("abcdefghij")

    private func printSymbolColour(ch: Int) {
        PrintColour(color: GetColour(ch: ch), text: GetSymbol(ch: ch).rawValue, terminator: "")
    }

    private func printDot<T>(ch: T)
    {
        if let ch = ch as? Int {
            printSymbolColour(ch: ch)
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
            printLine(line: coordXLine)
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
        PrintColour(color: ANSIColors.green, text: yourTitle, terminator: "\t\t")
        PrintColour(color: ANSIColors.red, text: enemyTitle)
    }
    func PrintBottom() {
        PrintColour(color: ANSIColors.magenta, text: bottomLine)
        print()
    }

    func ClearConsole() {
        print("\u{001B}[2J", terminator: "")
        //        var clearScreen = Process()
//        clearScreen.launchPath = "/usr/bin/clear"
//        clearScreen.arguments = []
//        clearScreen.launch()
//        clearScreen.waitUntilExit()
    }

    public func PrintMap(player: Player) {
        ClearConsole()
        PrintTitle()
        for j in 0...coordY {
            printBlock(j: j, line: player.GetMap().GetFieldLine(coordY: j == 0 ? 0 : (j - 1)))
            print("\t\t", terminator: "")
            printBlock(j: j, line: player.GetEnemyMap().GetFieldLine(coordY: j == 0 ? 0 : (j - 1)))
            print(".")
        }
        PrintBottom()
    }

    public func AnnouncementOfResults(haveShip: Bool) {
        var color: ANSIColors
        var text: String
        if haveShip {
            color = ANSIColors.green
            text = winMessage
        } else {
            color = ANSIColors.cyan
            text = loseMessage
        }
        PrintColour(color: color, text: text)
    }
    public func PrintLastStep(logLastStep: ShotValue?) {
        if let log = logLastStep {
            print(enemyText, terminator: " ")
            PrintColour(color: ANSIColors.yellow ,text: "\(coordXLine[log.coordX])\(log.coordY + 1)", terminator: ".")
            PrintColour(color: log.shot ? ANSIColors.red : ANSIColors.cyan, text: " \(log.shot ? shotShipText : missText)", terminator: "" )
            if log.shot {
                PrintColour(color: log.shot ? ANSIColors.red : ANSIColors.cyan, text: "\(log.kill ? killText : notKillText)", terminator: "" )
            }
           print()
        }
    }

    public func PrintLastStep(logLastStep: [ShotValue?]?) {
        if let logs = logLastStep {
            for log in logs {
                PrintLastStep(logLastStep: log)
            }
        }
    }
}

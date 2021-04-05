//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class PrintConsoleGame: PrinterGame {

    let winMessage = "Congratulations!!! You Win!!!"
    let loseMessage = "So sad, your Lost...Try again - you can do it"
    let enemyTitle = " + + + EnemyField + + + "
    let yourTitle = " + + + YourField + + +"
    let bottomLine = "------------------------------------------------------"
    let shotShipText = "He shot your ship"
    let missText = "He missed"
    let killText = " and kill"
    let notKillText = ", but not kill"
    let enemyText = "Enemy shot to"
    let successShot = " Good Shot ┐(・。・┐) ♪"
    let successKill = " The ship is blown up ᕦ༼◣_◢༽つ"
    let quitText = "See you! s( ^ ‿ ^)-b"
    let toDoText = "//TODO (⊃｡•́‿•̀｡)⊃━☆ﾟ.*･｡ﾟ"
    let ship = """
               ░█▀▀▀█ ░█▀▀▀ ─█▀▀█ 　 ░█▀▀█ ─█▀▀█ ▀▀█▀▀ ▀▀█▀▀ ░█─── ░█▀▀▀ 
               ─▀▀▀▄▄ ░█▀▀▀ ░█▄▄█ 　 ░█▀▀▄ ░█▄▄█ ─░█── ─░█── ░█─── ░█▀▀▀ 
               ░█▄▄▄█ ░█▄▄▄ ░█─░█ 　 ░█▄▄█ ░█─░█ ─░█── ─░█── ░█▄▄█ ░█▄▄▄\n
               """
    let coordY = 10
    let coordXLine = Array<Character>("abcdefghij")
    private var isClearConsole = true

    private func printSymbolColour(ch: Int) {
        PrintColour(color: GetColourByInt(ch: ch), text: GetSymbol(ch: ch).rawValue, terminator: "")
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

    func PrintToDo() {
        PrintColour(color: ANSIColors.yellow, text: toDoText)
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
        if isClearConsole {
            print("\u{001B}[2J", terminator: "")
        }
    }

    func PrintSettings(settings: Settings) {
        ClearConsole()
        PrintColour(color: ANSIColors.green, text: ship)

        for (index, pos) in SettingsText.ListAll().enumerated() {
            var turnOn: Bool? = nil

            switch pos {
            case SettingsText.printerClearText:
                turnOn = settings.GetSettings().consoleClear
            case SettingsText.stepFirstText:
                turnOn = settings.GetSettings().stepFirstPlayer
            default:
                turnOn = nil
            }
            if let isTurn = turnOn {
                PrintColour(color: ANSIColors.magenta, text: "\(index + 1) - \(pos): \(isTurn)")
            } else {
                PrintColour(color: ANSIColors.magenta, text: "\(index + 1) - \(pos)")
            }
        }
    }

    func PrintMenu() {
        ClearConsole()
        PrintColour(color: ANSIColors.green, text: ship)
        for (index, menu) in MenuText.ListAll().enumerated() {
            PrintColour(color: ANSIColors.magenta, text: "\(index + 1) - \(menu)")
        }
    }

    public func PrintQuitMessage() {
        ClearConsole()
        PrintColour(color: ANSIColors.magenta, text: quitText)
    }

    public func PrintMap(player: Player?) {
        ClearConsole()
        PrintTitle()
        for j in 0...coordY {
            printBlock(j: j, line: player!.GetMap().GetFieldLine(coordY: j == 0 ? 0 : (j - 1)))
            print("\t\t", terminator: "")
            printBlock(j: j, line: player!.GetEnemyMap().GetFieldLine(coordY: j == 0 ? 0 : (j - 1)))
            print()
        }
        PrintBottom()
    }

    public func SetSettingsPrint(clearConsole: Bool = true) {
        isClearConsole = clearConsole
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

    public func PrintShot(logLastShot: ShotValue?) {
        let shot = logLastShot

        if shot != nil {
            PrintColour(color: ANSIColors.yellow ,text: "\(coordXLine[shot!.coordX])\(shot!.coordY + 1)", terminator: ".")
        }
        if logLastShot?.shot == true {
            PrintColour(color: ANSIColors.green, text: successShot, terminator: ".")
        }
        if logLastShot?.kill == true {
            PrintColour(color: ANSIColors.red, text: successKill, terminator: ".")
        }
        if shot != nil {
            print()
        }
    }
}

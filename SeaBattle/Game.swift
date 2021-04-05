//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class Game {

    private var player1: Player?
    private var player2: Player?
    private var printer: PrinterGame
    private var isStepFirstPlayer: Bool

    init() {
        isStepFirstPlayer = true
        printer = PrintConsoleGame()
    }

    func GetPlayer1() -> Player? {
        return player1
    }

    func GetPlayer2() -> Player? {
        return player2
    }

    func StepPlayer(isStepFirstPlayer: Bool, friend: Player, enemy: Player) -> Bool {
        let (coordY, coordX) = friend.GetCoordinate(map: friend.GetEnemyMap())
        let (kill, shot) = enemy.MakeShot(coordY: coordY, coordX: coordX)
        let value = shot ? SymbolField.Hit.rawValue : SymbolField.Miss.rawValue

        friend.SetEnemyMap(coordY: coordY, coordX: coordX, value: value,kill: kill)
        enemy.SetFriendMap(coordY: coordY, coordX: coordX, value: value,kill: kill)
        return shot ? isStepFirstPlayer : !isStepFirstPlayer
    }

    func ChangeSettings(settings: inout Settings) {
        var num = 0

        while num != SettingsText.getIndexToMenu {
            printer.PrintSettings(settings: settings)
            num = InputPlayer.GetCase() - 1
            switch num {
            case SettingsText.getToPrinterClearIndex:
                settings.SetConsoleClear(consoleClear: !settings.GetSettings().consoleClear)
            case SettingsText.getStepFirstIndex:
                settings.SetStepFirst(stepFirst: !settings.GetSettings().stepFirstPlayer)
            case SettingsText.getIndexToMenu:
                break
            default: break
            }
        }
    }

    func StartGame() {
        var menu = Menu.mainMenu
        var settings = Settings()

        printer.PrintMenu()
        while menu != Menu.quitGame {
            menu = InputPlayer.ParsePlayerInput(menu: menu)
            switch menu {
            case .startMatch:
                InitializeGame(settings: settings)
                StartMatch()
            case .mainMenu:
                printer.PrintMenu()
            case .settings:
                ChangeSettings(settings: &settings)
                printer.SetSettingsPrint(clearConsole: settings.GetSettings().consoleClear)
            case .quitGame:
                printer.PrintQuitMessage()
            }
        }
    }

    func StartMatch() {
        var lastStepId: Int = 0

        while player1?.isAlive ?? false && player2?.isAlive ?? false  {
            if isStepFirstPlayer {
                game.printer.PrintMap(player: game.GetPlayer1())
                let logLastEnemyStep = player2?.GetLastStep()
                let logLastShot = player1?.GetLastShot()
                game.printer.PrintShot(logLastShot: logLastShot)
                if logLastEnemyStep?.last != nil && logLastEnemyStep?.last??.id ?? 0 > lastStepId {
                    game.printer.PrintLastStep(logLastStep: logLastEnemyStep)
                    lastStepId = logLastEnemyStep?.last??.id ?? 0
                }
                isStepFirstPlayer = StepPlayer(isStepFirstPlayer: isStepFirstPlayer, friend: player1!, enemy: player2!)
            } else {
                isStepFirstPlayer = StepPlayer(isStepFirstPlayer: isStepFirstPlayer, friend: player2!, enemy: player1!)
            }
        }
        game.printer.PrintMap(player: game.GetPlayer1())
        game.printer.AnnouncementOfResults(haveShip: player1?.isAlive ?? false )
    }

    func InitializeGame(settings: Settings) {
        isStepFirstPlayer = settings.GetSettings().stepFirstPlayer
        player1 = Player(filler: RandomFillField(), stepper: ParsStepper(), logger: LogGame())
        player2 = Player(filler: RandomFillField(), stepper: AIStepper(), logger: LogGame())
    }
}

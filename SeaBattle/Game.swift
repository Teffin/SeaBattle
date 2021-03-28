//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class Game {
    private var player1: Player
    private var player2: Player
    private var printer: PrinterMap
    private var isStepFirstPlayer: Bool

    init() {
        isStepFirstPlayer = true
        player1 = Player(filler: RandomFillField(),stepper: ParsStepper())
        player2 = Player(filler: RandomFillField(), stepper: AIStepper())
        printer = PrintConsoleMap()
    }

    func GetPlayer1() -> Player {
        return player1
    }
    func GetPlayer2() -> Player {
        return player2
    }

    func StepPlayer(isStepFirstPlayer: Bool, friend: Player, enemy: Player) -> Bool {
        let (coordY, coordX) = friend.GetCoordinate(map: friend.GetEnemyMap())
        let (kill, shot) = enemy.MakeShot(coordY: coordY, coordX: coordX)
        let value = shot ? SymbolField.Hit.rawValue : SymbolField.Miss.rawValue
        friend.SetEnemyMap(coordY: coordY, coordX: coordX, value: value,kill: kill)
        enemy.SetFriendMap(coordY: coordY, coordX: coordX, value: value,kill: kill)
        if shot {
            return isStepFirstPlayer
        } else {
            return !isStepFirstPlayer
        }
    }

    func StartGame() {
        while player1.isAlive && player2.isAlive {
            if isStepFirstPlayer {
                game.printer.PrintMap(player: game.GetPlayer1())
                isStepFirstPlayer = StepPlayer(isStepFirstPlayer: isStepFirstPlayer, friend: player1, enemy: player2)
            } else {
                isStepFirstPlayer = StepPlayer(isStepFirstPlayer: isStepFirstPlayer, friend: player2, enemy: player1)
            }
        }
        game.printer.PrintMap(player: game.GetPlayer1())
        game.printer.AnnouncementOfResults(haveShip: player1.isAlive)
    }
}
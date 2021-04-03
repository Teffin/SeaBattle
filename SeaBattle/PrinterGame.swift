//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

protocol PrinterGame {

    func PrintMap(player: Player)
    func PrintLastStep(logLastStep: [ShotValue?]?)
    func AnnouncementOfResults(haveShip: Bool)
    func PrintSuccessShot()
    func PrintQuitMessage()
    func PrintMenu()
    func PrintToDo()
    func SetSettingsPrint(clearConsole: Bool)
}

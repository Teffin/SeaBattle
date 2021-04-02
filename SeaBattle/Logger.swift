//
// Created by Henly Harrold on 4/2/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

protocol Logger {

    func SaveShot(coordX: Int, coordY: Int, shot: Bool, kill: Bool)
    func GetLastShot() -> ShotValue?
    func GetLastStep() -> [ShotValue?]?
    func GetLogGame() -> [ShotValue?]?
    func FreeLastStep()
}

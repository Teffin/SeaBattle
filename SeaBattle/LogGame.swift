//
// Created by Henly Harrold on 4/2/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation



class LogGame: Logger {

    private var id: Int
    private var lastShot: ShotValue?
    private var lastStep: [ShotValue?]?
    private var gameLog: [ShotValue?]?

    init() {
        id = 0
        lastShot = nil
        lastStep = [ShotValue?]()
        gameLog = [ShotValue?]()
    }

    private func SaveStep(lastShot: ShotValue?) {
        if lastStep?.last??.shot == false {
            lastStep?.removeAll()
        }
        lastStep?.append(lastShot)
    }

    public func SaveShot(coordX: Int, coordY: Int, shot: Bool, kill: Bool) {
        id += 1
        lastShot = ShotValue(id: id, coordX: coordX, coordY: coordY, shot: shot, kill: kill)
        SaveStep(lastShot: lastShot)
        gameLog?.append(lastShot)
    }

    public func GetLastShot() -> ShotValue? {
        lastShot
    }

    public func GetLastStep() -> [ShotValue?]? {
        lastStep
    }

    public func GetLogGame() -> [ShotValue?]? {
        gameLog
    }

    public func FreeLastStep() {
        lastStep?.removeAll()
    }
}

//
// Created by Henly Harrold on 4/4/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

 struct Settings {
    private var isStepFirstPlayer: Bool
    private var isConsoleClear: Bool
    private var isHorizontalRotation: Bool

    init() {
        isStepFirstPlayer = true
        isConsoleClear = true
        isHorizontalRotation = true
    }

    func GetSettings() -> (stepFirstPlayer: Bool, consoleClear: Bool, isHorizontalRotation: Bool) {
        (isStepFirstPlayer, isConsoleClear, isHorizontalRotation)
    }

    mutating func SetConsoleClear(consoleClear: Bool) {
        self.isConsoleClear = consoleClear
    }

    mutating func SetStepFirst(stepFirst: Bool) {
        self.isStepFirstPlayer = stepFirst
    }

    mutating func SetRotation(isHorizontalRotation: Bool) {
        self.isHorizontalRotation = isHorizontalRotation
    }
}

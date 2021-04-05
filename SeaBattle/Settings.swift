//
// Created by Henly Harrold on 4/4/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

 struct Settings {
    private var isStepFirstPlayer: Bool
    private var isConsoleClear: Bool

    init() {
        isStepFirstPlayer = true
        isConsoleClear = true
    }

     func GetSettings() -> (stepFirstPlayer: Bool, consoleClear: Bool) {
        (isStepFirstPlayer, isConsoleClear)
    }

    mutating func SetConsoleClear(consoleClear: Bool) {
        self.isConsoleClear = consoleClear
    }

    mutating func SetStepFirst(stepFirst: Bool) {
        self.isStepFirstPlayer = stepFirst
    }

}

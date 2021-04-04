//
// Created by Henly Harrold on 4/4/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

struct SettingsText {
    static let printerClearText = "Clear console every Step"
    static let stepFirstText = "First Step is Player"
    static let goMenuText = "Go to menu"

    static public var getIndexToMenu = ListAll().index(of: SettingsText.goMenuText)
    static public var getStepFirstIndex = ListAll().index(of: SettingsText.stepFirstText)
    static public var getToPrinterClearIndex = ListAll().index(of: SettingsText.printerClearText)

    static func ListAll() -> [String] {
        return [printerClearText, stepFirstText, goMenuText]
    }
}

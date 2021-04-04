//
// Created by Henly Harrold on 4/4/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

struct MenuText {
    static let menuStartText = "Start Game ⎈"
    static let menuSettingsText = "Settings ✎"
    static let menuExitText = "Quit Game ☂"

    lazy var count = MenuText.ListAll().count

    static func ListAll() -> [String] {
        return [menuStartText, menuSettingsText, menuExitText]
    }
}

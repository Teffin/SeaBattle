//
// Created by Henly Harrold on 3/26/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

enum SymbolMap: String {
    case Ship = "#"
    case Terra = "."
    case Miss = "*"
    case Empty = "X"
    case Hit = "@"
    case Error = "?"
}

func GetSymbol(ch: Int) -> SymbolMap {
    switch(ch) {
    case 1...10:
        return .Ship
    case 0:
        return .Terra
    case -1:
        return .Miss
    case -2:
        return .Empty
    case -3:
        return .Hit
    default:
        return .Error
    }
}

enum SymbolField: Int {
    case Ship = 1
    case Terra = 0
    case Miss = -1
    case Empty = -2
    case Hit = -3
    case Error = -4
}

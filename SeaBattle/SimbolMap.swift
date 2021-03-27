//
// Created by Henly Harrold on 3/26/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

enum SimbolMap: String {
    case Ship = "#"
    case Terra = "."
    case Miss = "*"
    case Empty = "X"
    case Hit = "@"
    case Error = "?"
}

func GetSimbol(ch: Int) -> SimbolMap {
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
    case -4:
        return .Hit
    default:
        return .Error
    }
}
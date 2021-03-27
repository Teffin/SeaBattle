//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class ParsSteper: Stepper {
    func GetCoordinate(map: Map) -> (coordY: Int, coordX: Int) {
        var coordX: Int
        var coordY: Int
        coordX = Int.random(in: 0..<10)
        coordY = Int.random(in: 0..<10)

        while map.GetFieldPoint(coordY: coordY, coordX: coordX) < 0 {
            coordX = Int.random(in: 0..<10)
            coordY = Int.random(in: 0..<10)
        }
        return (coordX, coordY)
    }
}

//
// Created by Henly Harrold on 3/27/21.
// Copyright (c) 2021 ___School21___. All rights reserved.
//

import Foundation

class Player {
    private var map: Map
    private var enemyMap = Map()
    private var stepper: Stepper

    init(filler: Filler, stepper: Stepper) {
        map = filler.RandomFillMap()
        self.stepper = stepper
    }

    var isAlive: Bool {
        return map.isAnyShip
    }

    func GetMap() -> Map {
        return self.map
    }

    public func GetEnemyMap() -> Map {
        return self.enemyMap
    }
    func SetField(sameMap: inout Map, coordY: Int, coordX: Int, value: Int, kill: Bool) {
        sameMap.SetFieldPoint(coordY: coordY, coordX: coordX, value: value)
        if kill {
            sameMap.SetVoidField(coordY: coordY, coordX: coordX)
        }
    }

    func SetEnemyMap(coordY: Int, coordX: Int, value: Int, kill: Bool) {
        SetField(sameMap: &enemyMap, coordY: coordY, coordX: coordX, value: value, kill: kill)
    }

    func GetCoordinate(map: Map) -> (Int, Int) {
        return stepper.GetCoordinate(map: map)
    }

    func MakeShot(coordY: Int, coordX: Int) -> (kill: Bool, shot: Bool) {
        var kill = false
        var shot = false
        var value = -1
        let ship = map.GetFieldPoint(coordY: coordY, coordX: coordX)
        if ship > 0 {
            shot = true
            value = -3
            if map.SetShips(ship: ship) == 0 {
                kill = true
            }
        }
        SetField(sameMap: &map, coordY: coordY, coordX: coordX, value: value, kill: kill)
        return (kill, shot)
    }
}

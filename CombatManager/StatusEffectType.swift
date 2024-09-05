//
//  StatusEffect.swift
//  CombatManager
//
//  Created by Tyler Radke on 9/3/24.
//

import Foundation

enum StatusEffectType: Hashable {
    case stun
    case damageOverTime
    case healOverTime
}

class StatusEffect {
    var type: StatusEffectType
    var amount: Int?
    var turnsLeft: Int
    
    var description: String {
        "\(type) has \(turnsLeft) turns left, at \(amount ?? 0) points."
    }
    
    init(type: StatusEffectType, amount: Int? = nil, turnsLeft: Int) {
        self.type = type
        self.amount = amount
        self.turnsLeft = turnsLeft
    }
}



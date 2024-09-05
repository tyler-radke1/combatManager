//
//  Ability.swift
//  CombatManager
//
//  Created by Tyler Radke on 9/3/24.
//

import Foundation

enum AbilityType {
    case attack
    case defense
}
protocol Ability {
    func action(on target: Character)
    var name: String { get }
    var type: AbilityType { get }
}

struct Attack: Ability {
    var type: AbilityType = .attack
    var name = "Attack"
    func action(on target: Character) {
        let damage = Int.random(in: 5...15)
        print(damage)
        target.health -= damage
    }
}

struct Heal: Ability {
    var type: AbilityType = .defense
    var name = "Heal"
    func action(on target: Character) {
        let health = Int.random(in: 5...15)
        print(health)
        target.health += health
    }
}

struct Stun: Ability {
    var type: AbilityType = .attack
    var name = "Stun"
    func action(on target: Character) {
        let stun = StatusEffect(type: .stun, turnsLeft: 3)
        print("turn skipped, stunned")
        target.effects.append(stun)
    }
}

struct DamageOverTime: Ability {
    var type: AbilityType = .attack
    var name = "Damage Over Time"
    func action(on target: Character) {
        let dot = StatusEffect(type: .damageOverTime, amount: 3, turnsLeft: 3)
        print("Took 3 damage from dot")
        target.effects.append(dot)
    }
}

struct HealOverTime: Ability {
    var name = "Heal Over Time"
    var type: AbilityType = .defense
    func action(on target: Character) {
        let health = StatusEffect(type: .healOverTime, amount: 3, turnsLeft: 3)
        print("Healed 3 health from hot")
        target.effects.append(health)
    }
}

struct SuperAttack: Ability {
    var type: AbilityType = .attack
    var name = "Tyler's super mega ultra attack."
    func action(on target: Character) {
        print("Enemy destroyed")
        target.health = 0
    }
}

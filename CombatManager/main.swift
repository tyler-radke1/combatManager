//
//  main.swift
//  CombatManager
//
//  Created by Tyler Radke on 9/3/24.
//

import Foundation

class Character {
    var health = 100
    var maxHealth = 100
    var abilities: [Ability]
    var effects: [StatusEffect] = []
    
    init(health: Int = 100, maxHealth: Int = 100, abilities: [Ability], effects: [StatusEffect]) {
        self.health = health
        self.maxHealth = maxHealth
        self.abilities = abilities
        self.effects = effects
    }
    
    static var player = Character(abilities: [Attack(), Heal(), Stun(), DamageOverTime(), SuperAttack()], effects: [])
    static var enemy = Character(abilities: [Attack()], effects: [])
}


class CombatManager {
    var player: Character
    var enemy: Character
    var isPlayerTurn = true
    var battleIsFinished = false
    
    init(player: Character, enemy: Character) {
        self.player = player
        self.enemy = enemy
    }
    
    func startBattle() {
        while !battleIsFinished {
            if isPlayerTurn {
                playerTurn()
            } else {
                enemyTurn()
            }
        }
        
        endBattle()
    }
    
    func playerTurn() {
        print("Player: \(player.health)")
        print("Enemy: \(enemy.health)")
        checkEffects(for: player)
        
        for (index, ability) in player.abilities.enumerated() {
            print("\(index). \(ability.name)")
        }
        
        if let choice = Int(readLine() ?? "") {
            switch choice {
            case 0..<player.abilities.count:
                let ability = player.abilities[choice]
                ability.action(on: ability.type == .attack ? enemy : player)
                print("Player used \(ability.name)")
            default:
                print("Invalid String")
            }
        }
        isPlayerTurn = false
        battleIsFinished = player.health <= 0 || enemy.health <= 0
    }
    
    func enemyTurn() {
        checkEffects(for: enemy)
        
        if let ability = enemy.abilities.randomElement() {
            ability.action(on: ability.type == .attack ? player : enemy)
            print("Enemy used \(ability.name)")
        }
        
        isPlayerTurn = true
        battleIsFinished = player.health <= 0 || enemy.health <= 0
    }
    
    func endBattle() {
        if player.health == 0 {
            print("Battle over. Player lost")
        } else {
            print("Battle over. Player won")
        }
        
        battleIsFinished = true
    }
    
    func checkEffects(for target: Character) {
        for (index, effect) in target.effects.enumerated() {
            switch effect.type {
            case .stun:
                isPlayerTurn = false
            case .damageOverTime:
                target.health -= effect.amount ?? 0
            case .healOverTime:
                target.health += effect.amount ?? 0
            }
            
            if effect.turnsLeft > 1 {
                effect.turnsLeft -= 1
            } else {
                target.effects.remove(at: index)
            }
            print(effect.description)
        }
    }
}

var manager = CombatManager(player: Character.player, enemy: Character.enemy)

manager.startBattle()

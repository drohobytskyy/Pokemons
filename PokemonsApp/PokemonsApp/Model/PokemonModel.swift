//
//  Pokemon.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import Foundation

//MARK: - Pokemon data model
struct Pokemon: Codable {
    let name: String?
    let url: String?
}

//MARK: - PokemonDetails data model
struct PokemonDetails: Codable {
    let id: Int?
    let order: Int?
    let name: String?
    let height: Int?
    let weight: Int?
    let base_experience: Int?
    let abilities: [Abilities]?
    let sprites: Sprites?
    
    struct Ability: Codable {
        let name: String?
        let url: String?
    }
    
    struct Abilities: Codable {
        let ability: Ability?
        let slot: Int?
    }
    
    struct Sprites: Codable {
        let front_default: String?
        let back_default: String?
    }
}

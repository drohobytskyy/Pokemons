//
//  Pokemon.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    struct Sprites: Codable{
        let front_default: String?
        let back_default: String?
    }
}

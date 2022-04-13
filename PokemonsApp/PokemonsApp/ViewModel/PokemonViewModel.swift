//
//  PokemonViewModel.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import Foundation

protocol PokemonViewModelProtocol {
    var pokemons: (([Pokemon]) -> ())? { get set }
    var offset: Int { get set }
    var hasNextPage: Bool { get }
    
    func fetchPokemons()
}

class PokemonViewModel: PokemonViewModelProtocol {
    var pokemons: (([Pokemon]) -> ())?
    var offset: Int = 0
    var hasNextPage: Bool = true
    
    init() {
        self.pokemons?([])
    }
    
    func fetchPokemons() {
        WebAPI.shared.fetchPokemons(with: self.offset) { [weak self] results in
            switch results {
            case .failure(_):
                self?.pokemons?([])
                break
            case .success(let response):
                self?.hasNextPage = !(response.next ?? "").isEmpty
                self?.pokemons?(response.results)
                break
            }
        }
    }
}

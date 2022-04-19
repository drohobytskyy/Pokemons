//
//  PokemonViewModel.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

// Class responsible for binding data to PokemonsViewController
// binding var - pokemons: (([PokemonDetails]) -> ())? { get set }
// Instance methods:
/// fetchPokemons()
/// fetchPokemonsDetails(pokemons: [Pokemon], completion: @escaping (Bool) -> Void)
// Class methods
/// serach(by text: String, pokemons: [PokemonDetails]) -> [PokemonDetails]
/// getAbilities(pokemon: PokemonDetails) -> [String]

import Foundation

//MARK: - Protocols
protocol PokemonViewModelProtocol {
    var pokemons: (([PokemonDetails]) -> ())? { get set }
    var offset: Int { get set }
    var hasNextPage: Bool { get }
    
    func fetchPokemons()
}

class PokemonViewModel: PokemonViewModelProtocol {
    
    //MARK: - Instance vars
    var pokemons: (([PokemonDetails]) -> ())?
    var offset: Int = 0
    var hasNextPage: Bool = true
    
    private var pokemonDetailsList: [PokemonDetails]
    
    //MARK: - Init
    init() {
        self.pokemons?([])
        self.pokemonDetailsList = []
    }
    
    //MARK: - Public methods
    func fetchPokemons() {
        self.pokemonDetailsList = []
        WebAPI.shared.fetchPokemons(with: self.offset) { [weak self] results in
            switch results {
            case .failure(_):
                self?.pokemons?([])
            case .success(let response):
                self?.fetchPokemonsDetails(pokemons: response.results, completion: { finished in
                    if finished {
                        self?.hasNextPage = !(response.next ?? "").isEmpty
                        self?.pokemons?(self?.pokemonDetailsList ?? [])
                    }
                })
            }
        }
    }
    
    func fetchPokemonsDetails(pokemons: [Pokemon], completion: @escaping (Bool) -> Void) {
        var count = 0
        pokemons.forEach { pokemon in
            let url = URL(string: pokemon.url ?? "")
            let id = url?.pathComponents.last ?? "0"
            WebAPI.shared.fetchPokemonDetail(pokemonId: id) { (result) in
                switch result {
                case .failure:
                    count += 1
                    completion(count == pokemons.count)
                case .success(let pokemon):
                    count += 1
                    self.pokemonDetailsList.append(pokemon)
                    completion(count == pokemons.count)
                }
            }
        }
    }
    
    static func serach(by text: String, pokemons: [PokemonDetails]) -> [PokemonDetails] {
        pokemons.filter{ pokemon in
            if text.isNumber, let id = Int(text) {
                return pokemon.id == id
            } else {
                return (pokemon.name ?? "").lowercased().contains(text.lowercased())
            }
        }
    }
    
    static func getAbilities(pokemon: PokemonDetails) -> [String] {
        var results = [String]()
        if let abilities = pokemon.abilities {
            results.append(contentsOf: abilities.map{ String($0.ability?.name ?? "") })
        }
        
        return results
    }
}

//
//  PokemonsAppTests.swift
//  PokemonsAppTests
//
//  Created by @drohobytskyy on 12/04/2022.
//

import XCTest
@testable import PokemonsApp

class PokemonsAppTests: XCTestCase {
    
    private var pokemonsViewModel: PokemonViewModelProtocol!
    private let APIFetchResultsLimit = 200

    override func setUpWithError() throws {
        self.pokemonsViewModel = PokemonViewModel()
    }

    override func tearDownWithError() throws {
        self.pokemonsViewModel = nil
    }
    
    func testFetch() {
        let expect = expectation(description: "fetch pokemons")
        
        self.pokemonsViewModel.fetchPokemons()
        
        self.pokemonsViewModel.pokemons = { pokemons in
            expect.fulfill()
            XCTAssertEqual(pokemons.count, self.APIFetchResultsLimit, "Number of pokemons should be 200, result is: \(String(describing: pokemons.count))")
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testSerach() {
        let expect = expectation(description: "fetch pokemons and search")
        
        self.pokemonsViewModel.fetchPokemons()
        
        self.pokemonsViewModel.pokemons = { pokemons in
            expect.fulfill()
            
            let seachById = PokemonViewModel.serach(by: "1", pokemons: pokemons)
            XCTAssertEqual(seachById.count, 1, "Number of pokemons should be 1, result is: \(String(describing: pokemons.count))")
            XCTAssertEqual(seachById.first?.id, 1, "pokemon id should be 1, result is: \(String(describing: pokemons.count))")
            XCTAssertEqual(seachById.first?.name, "bulbasaur", "pokemon's name should be bulbasaur, result is: \(String(describing: pokemons.count))")
            
            let seachByName = PokemonViewModel.serach(by: "misdreavus", pokemons: pokemons)
            XCTAssertEqual(seachByName.count, 1, "Number of pokemons should be 1, result is: \(String(describing: pokemons.count))")
            XCTAssertEqual(seachByName.first?.id, self.APIFetchResultsLimit, "pokemon id should be 200, result is: \(String(describing: pokemons.count))")
            XCTAssertEqual(seachByName.first?.name, "misdreavus", "pokemon's name should be misdreavus, result is: \(String(describing: pokemons.count))")
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetAbilities() {
        let expect = expectation(description: "fetch pokemons, search and get abilities")
        
        self.pokemonsViewModel.fetchPokemons()
        
        self.pokemonsViewModel.pokemons = { pokemons in
            expect.fulfill()
            
            let seachById = PokemonViewModel.serach(by: "1", pokemons: pokemons)
            if let pokemon = seachById.first {
                let abilities = PokemonViewModel.getAbilities(pokemon: pokemon)
                XCTAssertEqual(abilities, ["overgrow", "chlorophyll"], "abilities should be: ['overgrow', 'chlorophyll'], result is: \(String(describing: pokemons.count))")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

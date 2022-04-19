//
//  File.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

// Class responsible for fetching pokemons data from external API
// Singleton design pattern
// Instance methods:
///  1.  fetchPokemons(with offset: Int, completion: @escaping (Result<Response,Error>) -> Void)
///  2.  fetchPokemonDetail(pokemonId: String, completion: @escaping (Result<PokemonDetails,Error>) -> Void)

import Foundation
import UIKit

class WebAPI {
    
    //MARK: - Singleton instance
    static let shared: WebAPI = WebAPI()
    
    //MARK: - API esponse
    struct Response: Codable {
        var count: Int
        var next: String?
        var results: [Pokemon]
    }
    
    //MARK: - Aditional errors
    enum APIError: Error {
        case invalidURL
        case fetchError
    }
    
    //MARK: - Instance vars
    private let baseURL: String = "https://pokeapi.co/api/v2/"
    private let limit: Int = 200
    
    //MARK: - Public methods
    func fetchPokemons(with offset: Int, completion: @escaping (Result<Response,Error>) -> Void) {
        guard let url = URL(string: self.baseURL + "pokemon?limit=\(limit)&offset=\(offset)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                guard let error = error else {
                    completion(.failure(APIError.fetchError))
                    return
                }

                completion(.failure(error))
                return
            }
            
            var result: Response?
            
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                completion(.failure(error))
            }
            
            guard let decodedResult = result else {
                return
            }
            
            completion(.success(decodedResult))
        }.resume()
    }
    
    func fetchPokemonDetail(pokemonId: String, completion: @escaping (Result<PokemonDetails,Error>) -> Void) {
        guard let url = URL(string: self.baseURL + "pokemon/" + pokemonId) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                guard let error = error else {
                    completion(.failure(APIError.fetchError))
                    return
                }
                
                debugPrint(error)
                completion(.failure(error))
                return
            }
            
            var result: PokemonDetails?
            
            do {
                result = try JSONDecoder().decode(PokemonDetails.self, from: data)
            } catch {
                completion(.failure(error))
                debugPrint(error)
            }
            
            guard let decodedResult = result else {
                return
            }
            
            completion(.success(decodedResult))
        }.resume()
    }
}


//
//  File.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import Foundation
import UIKit

class WebAPI {
    
    //MARK: - Singleton instance
    static let shared: WebAPI = WebAPI()
    
    //MARK: - Response data model
    struct Response: Codable {
        var count: Int
        var next: String?
        var results: [Pokemon]
    }
    
    //MARK: - Instance vars
    private let limit: Int = 200
    
    //MARK: - Public methods
    func fetchPokemons(with offset: Int, completion: @escaping (Result<Response,Error>) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error!))
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
        let url = "https://pokeapi.co/api/v2/pokemon/" + pokemonId
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            guard let data = data, error == nil else {
                debugPrint(error!)
                completion(.failure(error!))
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

    func getPokemonImage(from urlString: String, completion: @escaping (Result<UIImage,Error>) -> Void) {
        let pokemonURL = URL(string: urlString)
        URLSession.shared.dataTask(with: pokemonURL!) { (data, response, error) in
            if error != nil {
                debugPrint(error!)
                completion(.failure(error!))
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        completion(.success(image!))
                    } else {
                        let error = NSError(domain: "", code: -1, userInfo: nil)
                        completion(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


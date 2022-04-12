//
//  File.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import Foundation
import UIKit

class WebAPI {
    static let shared: WebAPI = WebAPI()
    
    struct Response: Codable {
        var count: Int
        var next: String?
        var results: [Pokemon]
    }
    
    private let limit: Int = 50
    
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
}


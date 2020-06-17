//
//  Service.swift
//  Pokedex Plus
//
//  Created by Iskierka, Julia on 15/06/2020.
//  Copyright © 2020 Iskierka Lipiec. All rights reserved.
//

import Foundation
import Alamofire
class Service {
    @Published var pokemons = [Any]()
    
//    typealias Response<T> = (_ result: AFResult<T>) -> Void
    
    static private let baseUrl = "https://pokeapi.co/api/v2/"
    
    static func getGenerationByNumber(gen: String) -> [Pokemon] {
        let pokemons = [Pokemon]()
        return pokemons
        
    }
//    static func getPoke(name: String, completionHalnder: @escaping (AFResult<Pokemon>) -> Void) {
//        getPokemonByName(name: name, completion: completionHalnder)
//    }
//
//    private static func getGenerationByNumber(gen: String) -> [Pokemon]{
//        var pokes = [Pokemon]()
//        AF.request(self.baseUrl + "generation/" + gen, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
//            (responseData) in
//            guard let data = responseData.data else {return}
//            do {
//            let generation = try JSONDecoder().decode(Generation.self, from: data)
//                let fewPokes = generation.pokemons.prefix(5)
//                fewPokes.forEach{poke in
//                    pokes.append(self.getPokemonByName(name: poke.name))
//                }
//            } catch {
//                print("Error decoding: \(error)")
//            }
//        }
//        return pokes
//    }
    
    static func getPokemonByName(name: String) {
        
        AF.request(self.baseUrl + "pokemon/" + name, method: .get).response {
//            response in
//             switch (response.result)
//            {
//                case .success(let json):
//                    let data = json as! NSDictionary
////                    pokemons.append(value)
//                    print("OKI:")
//                    print(data.object(forKey: "id"))
//                    break
//
//                case .failure(let error):
//                    print("ERROR: ")
//                    print(error)
//                    break
//            }
            
//            switch response.result {
//            case .success(let value):
//                let pokemon = try JSONDecoder().decode(Pokemon.self, from: value.unsafelyUnwrapped)
//                completion(.success(value))
//            case .failure(let error):
//                completion(.failure(error))
//            default:
//                fatalError("Aaaaa")
//            }
            
             (responseData) in
            guard let data = responseData.data else {return}
            do {
                print(data)
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                print(pokemon)
            } catch {
                print("Error decoing: \(error)")
            }
            
            
        }
    }
}

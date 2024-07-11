//
//  Webservice.swift
//  CryptoBloomSwiftUI
//
//  Created by Eray İnal on 10.07.2024.
//

import Foundation



class Webservice {
    
    func downloadCurrencies(url : URL, completion : @escaping(Result< [CryptoCurrency]?, DowloaderError >) -> Void ) {
        
        URLSession.shared.dataTask(with: url) { data, repsonse, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badURL))
            }
            
            guard let data = data , error == nil else{
                return completion(.failure(.noData))
            }
            
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
            
        }.resume()
        
        
    }
    
    
    
}



enum DowloaderError : Error {
    case badURL
    case noData
    case dataParseError
}

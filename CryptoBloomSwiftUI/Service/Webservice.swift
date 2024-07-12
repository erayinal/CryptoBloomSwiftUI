//
//  Webservice.swift
//  CryptoBloomSwiftUI
//
//  Created by Eray İnal on 10.07.2024.
//

import Foundation



class Webservice {
    
    
    /*
    //7:
    func downloadCurrenciesAsync(url: URL) async throws -> [CryptoCurrency] {  //.7 throws yapmamızın sebebi burada try catch değil de çağırdığımız yerde hataları ele alacağımız için
        
        let (data, _) =  try await URLSession.shared.data(from: url)
        
        let currincies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
        return currincies ?? []     //..7: '?? []' boşsa boş dönder demek
    }
     */
    
    
    
    //10: Mesela aşğıdaki gibi async olmayan bir fonksiyonu sonradan da async olarak kullanmak isteyebiliriz çünkü bir fonksiyonu daha önce sizden başka birisi yazmış olabilir ya da o fonksiyonu dışarıdan çekiyor olabiliriz yani müdehale edemeyebiliriz. Bu yüzden şuan Continuation ile async olmayan bir methodu async yapalım:
    func downloadCurrenciesCountinuation(url: URL) async throws -> [CryptoCurrency]{
        
        try await withCheckedThrowingContinuation { myContinuation in
            downloadCurrencies(url: url) { result in
                switch result{
                case .success(let cryptos ):
                    myContinuation.resume(returning: cryptos ?? [])
                    
                case .failure(let error):
                    myContinuation.resume(throwing: error)
                }
            }
        }
        
    }
    
    
    
    
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

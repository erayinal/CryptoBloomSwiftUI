//
//  CryptoCurrency.swift
//  CryptoBloomSwiftUI
//
//  Created by Eray İnal on 10.07.2024.
//

import Foundation


struct CryptoCurrency: Decodable, Identifiable, Hashable {  //1 Daha öncesinde Identifiable yazmamıştık
    
    let id = UUID()
    let currency: String
    let price: String
    
    
    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
        //2 Bunu yapmamızın nedeni: bizim verileri aldığımız yerde 'id' diye bir şey yok ve bizde burada price ve currency'nin hangi isimlerle geleceğini söyledik, ve artık id diye bir şey beklemiyor. Id beklemediği için direkt kendisi bir id atayacak.
    }
}

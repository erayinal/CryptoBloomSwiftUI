//
//  CryptoViewModal.swift
//  CryptoBloomSwiftUI
//
//  Created by Eray İnal on 10.07.2024.
//

import Foundation


class CryptoListViewModal : ObservableObject {      //5 ObservableObject: burada olan bir değişikliği anında diğer sayfada da gerçekleşmesini sağlayacak '@Published' ile kullanınca. Ayrınca burayı sınıf yapmamızın nedeni de bu, çünkü ObservableObject struct'lar ile kullanılamaz
    
    let webservice = Webservice()
    
    
    @Published var cryptoList = [CryptoViewModal]()
    
    
    func downloadCryptos(url : URL){
        webservice.downloadCurrencies(url: url) { result in
            
            switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                
                case .success(let cryptos):
                
                    if let cryptos = cryptos {
                        //self.cryptoList = cryptos.map(CryptoViewModal.init)  //.5 normalde böyle yazmıştık ama bunu da dispatchQueue içerisinde yazmalıyız aşağıdaki gibi:
                        DispatchQueue.main.async {
                            self.cryptoList = cryptos.map(CryptoViewModal.init)
                        }
                        
                        
                        //6 Şimdi bu class'ı ObservableObject ile gözlemlenebilir yaptık işte şimdi de gidip 'MainView' içerisinde gözlemlemek/kullanmak
                        
                    }
                
                
            }
        }
        
    }
    
    
    
    
}









struct CryptoViewModal {        //3
    
    let crypto : CryptoCurrency
    
    var id : UUID? {
        crypto.id
    }
    var currency : String {
        crypto.currency
    }
    var price : String {
        crypto.price
    }
    
    
}

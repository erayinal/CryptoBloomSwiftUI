//
//  ContentView.swift
//  CryptoBloomSwiftUI
//
//  Created by Eray İnal on 9.07.2024.
//

import SwiftUI

struct MainView: View {
    
    
    //.6:
    @ObservedObject var cryptoListViewModal : CryptoListViewModal
    
    init(){
        self.cryptoListViewModal = CryptoListViewModal()
    }
    
    
    
    var body: some View {
        
        NavigationView {
            
            List(cryptoListViewModal.cryptoList, id: \.id){ crypto in
                
                HStack{
                    Text(crypto.currency)
                        .font(.title2)
                        .foregroundColor(.blue)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    
                    Text(crypto.price)
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    
                }.padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                
            }.navigationTitle(Text("Crypto Bloom "))
            
        }.onAppear{
            cryptoListViewModal.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        
        
    }
}


#Preview {
    MainView()
}

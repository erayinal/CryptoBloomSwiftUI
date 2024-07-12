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
                
            }//12: Eğer mesela biz her seferinde yenilemesini değil de sadece yenileme butonuna basılınca verilerin yenilenmesini istiyorsak ne olacak: Bu yüzden .task içeriğini yorum satırına alıyoruz ve toolbar içerisindeki butona kodlarımızı yazıyoruz
            .toolbar(content: {
                Button {
                    Task.init{
                        await cryptoListViewModal.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                } label: {
                    Text("Refresh")
                }

            })
            
            .navigationTitle(Text("Crypto Bloom "))
            
        }
        
        
        /* //.12: yorum satırına aldım
        .task {    //9: onAppear içersinde yazmadık çünkü onAppear async değil, ama .task direkt kendisi async
            
            //10: aşağıdaki yeri yorum satırına alıp yeninsini yzıyoruz
            await cryptoListViewModal.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            
            /*
            await cryptoListViewModal.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
             */
        }
        */
        
        
        
        /*
        .onAppear{
            cryptoListViewModal.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
         */
        
        
        
    }
}


#Preview {
    MainView()
}

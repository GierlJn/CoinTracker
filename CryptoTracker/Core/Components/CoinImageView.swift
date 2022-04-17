//
//  ImageLoader.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 16.04.22.
//

import SwiftUI
import Combine


struct CoinImageView: View {
  
  @StateObject var vm: CoinImageViewModel
  
  init(imageUrl: String){
    _vm = StateObject(wrappedValue: CoinImageViewModel(imageUrl: imageUrl))
  }
  
    var body: some View {
      Group{
        if vm.image != nil{
          Image(uiImage: vm.image!)
            .resizable()
            .scaledToFit()
        }else if vm.isLoading{
          ProgressView()
        }else{
          Image("questionmark")
        }
      }
      
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
      CoinImageView(imageUrl: CoinModel.mockData.image)
        .previewLayout(.sizeThatFits)
    }
}

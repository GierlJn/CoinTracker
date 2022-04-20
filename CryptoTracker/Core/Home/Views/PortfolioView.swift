//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 19.04.22.
//

import SwiftUI

struct PortfolioView: View {
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var vm: HomeViewModel
  @State private var selectedCoin: CoinModel? = nil
  @State private var quantityText: String = ""
  @State private var showCheckmark: Bool = false
  
  var body: some View {
    NavigationView{
      ScrollView{
        VStack{
          SearchBarView(input: $vm.searchText)
            .padding()
          coinLogoList
            .padding()
          if selectedCoin != nil{
            portfolioInputSection
          }
        }
      }
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            dismiss()
          } label: {
            Image(systemName: "xmark")
              .font(.headline)
          }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          saveButton
        }
      })
      .onChange(of: vm.searchText) { newValue in
        if newValue == ""{
          removeSelectedCoin()
        }
      }
      .navigationTitle("Edit Portfolio")
    }
    
  }
}

struct PortfolioView_Previews: PreviewProvider {
  static var previews: some View {
    PortfolioView()
      .environmentObject(HomeViewModel())
  }
}

extension PortfolioView{
  var coinLogoList: some View{
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack{
        ForEach(vm.allCoins) { coin in
          VStack{
            CoinImageView(coin: coin)
              .frame(width: 50, height: 50)
            Text(coin.name)
              .font(.headline)
            Text(coin.name)
              .font(.caption)
              .foregroundColor(Color.colorTheme.secondaryText)
          }
          
          .onTapGesture {
            selectedCoin = coin
          }
          .padding()
          .background{
            if coin == selectedCoin{
              RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foregroundColor(Color.colorTheme.green)
            }
          }
        }
      }
    }
  }
  
  private var saveButton: some View{
    Button {
      saveButtonPressed()
    } label: {
      HStack{
        Image(systemName: "checkmark")
          .opacity(showCheckmark ? 1.0 : 0.0)
        Text("Save".uppercased())
          .font(.headline)
          .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
      }
    }
  }
  
  private var portfolioInputSection: some View{
    VStack(spacing: 20){
      HStack{
        Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
        Spacer()
        Text(selectedCoin?.currentPrice.asUsd2Decimal() ?? "")
      }
      Divider()
      HStack{
        Text("Amount holding:")
        Spacer()
        TextField("Ex: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }
      Divider()
      HStack{
        Text("Current value:")
        Spacer()
        Text(getCurrentValue().asUsd2Decimal())
      }
    }
    .padding()
    .font(.headline)
  }
  
  func getCurrentValue() -> Double{
    if let quantity = Double(quantityText){
      return quantity * (selectedCoin?.currentPrice ?? 0)
    }
    return 0
  }
  
  func saveButtonPressed(){
    
    guard let coin = selectedCoin else { return }
    
    
    withAnimation(.easeIn){
      showCheckmark = true
      removeSelectedCoin()
    }
    
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      withAnimation(.easeOut){
        showCheckmark = false
      }
    }
    
  }
  
  private func removeSelectedCoin(){
    selectedCoin = nil
    vm.searchText = ""
  }
}

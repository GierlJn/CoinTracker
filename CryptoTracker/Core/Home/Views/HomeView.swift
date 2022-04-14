//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 14.04.22.
//

import SwiftUI

struct HomeView: View {
  
  @State private var showPortfolio: Bool = false
  
  var body: some View {
    ZStack{
      Color.colorTheme.background
        .ignoresSafeArea()
      
      VStack{
        headerView
        Spacer()
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView{
      HomeView()
        .navigationBarHidden(true)
    }
  }
}

extension HomeView{
  
  var headerView: some View{
    HStack{
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
        .background{
          CircleButtonAnimationView(animate: $showPortfolio)
        }
      Spacer()
      Text(showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.colorTheme.accent)
        .animation(.none)
      Spacer()
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()){
            showPortfolio.toggle()
          }
        }
        .padding(.horizontal)
    }
    
  }
}

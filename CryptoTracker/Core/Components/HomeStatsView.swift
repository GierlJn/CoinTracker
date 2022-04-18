//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 18.04.22.
//

import SwiftUI

struct HomeStatsView: View {
  
  @EnvironmentObject var homeViewModel: HomeViewModel
  
  var body: some View {
    HStack{
      ForEach(homeViewModel.statistics) { statistic in
        StatisticView(statistic: statistic)
          .frame(width: UIScreen.main.bounds.width / 3)
      }
    }
    
    .frame(width: UIScreen.main.bounds.width,
           alignment: homeViewModel.showPortfolio ? .trailing : .leading)
    
  }
}

struct HomeStatsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeStatsView()
      .environmentObject(HomeViewModel())
      .previewLayout(.sizeThatFits)
    
    HomeStatsView()
      .environmentObject(HomeViewModel())
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.dark)
    
  }
}

//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 18.04.22.
//

import SwiftUI

struct StatisticView: View {
  
  var statistic: StatisticModel
  
    var body: some View {
      VStack(alignment: .leading, spacing: 4){
        Text(statistic.title)
          .font(.caption)
          .foregroundColor(Color.colorTheme.secondaryText)
        Text(statistic.value)
          .font(.headline)
          .foregroundColor(Color.colorTheme.accent)
        HStack{
          Image(systemName: "triangle.fill")
            .rotationEffect((statistic.percentageChange ?? 0) > 0 ? Angle(degrees: 0) : Angle(degrees: 180))
          Text(statistic.percentageChange?.asPercentString() ?? "")
            .bold()
        }
        .font(.caption2)
        .foregroundColor((statistic.percentageChange ?? 0) > 0 ? .colorTheme.green : .colorTheme.red)
        .opacity((statistic.percentageChange != nil) ? 1 : 0)
      }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
      Group{
        StatisticView(statistic: StatisticModel.mockDataMC)
          .previewLayout(.sizeThatFits)
        
        StatisticView(statistic: StatisticModel.mockDataVol)
          .previewLayout(.sizeThatFits)
        
        StatisticView(statistic: StatisticModel.mockDataPorVal)
          .previewLayout(.sizeThatFits)
      
        StatisticView(statistic: StatisticModel.mockDataMC)
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
      
    }
}

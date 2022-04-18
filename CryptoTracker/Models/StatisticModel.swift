//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 18.04.22.
//

import Foundation

struct StatisticModel: Identifiable{
  let id = UUID()
  var title: String
  var value: String
  var percentageChange: Double?
  
  init(title: String, value: String, percentageChange: Double? = nil){
    self.title = title
    self.value = value
    self.percentageChange = percentageChange
  }
}

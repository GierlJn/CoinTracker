//
//  PortfolioEntity+Ext.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 21.04.22.
//

import Foundation

extension Collection where Element: PortfolioEntity{
  func portfolioSum()->Double{
    self.reduce(0) { partialResult, entity in
      return entity.amount + partialResult
    }
  }
  
}

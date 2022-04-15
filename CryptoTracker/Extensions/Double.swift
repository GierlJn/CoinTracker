//
//  Double.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import Foundation

extension Double{
  
  var currenyFormatterUsd6: NumberFormatter{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 6
    return numberFormatter
  }
  
  func asUsd6Decimal() -> String{
    currenyFormatterUsd6.string(from: NSNumber(value: self)) ?? "$0.00"
  }
  
}

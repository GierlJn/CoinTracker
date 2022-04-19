//
//  Double.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 15.04.22.
//

import Foundation

extension Double{
  
  var currenyFormatterUsd2: NumberFormatter{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 2
    return numberFormatter
  }
  
  func asUsd2Decimal() -> String{
    currenyFormatterUsd2.string(from: NSNumber(value: self)) ?? "$0.00"
  }

  
  func asNumberString() -> String{
    String(format: "%.2f", self)
  }
  
  func asPercentString() -> String{
    asNumberString() + "%"
  }
  
  func formattedWithAbbreviations() -> String {
      let num = abs(Double(self))
      let sign = (self < 0) ? "-" : ""

      switch num {
      case 1_000_000_000_000...:
          let formatted = num / 1_000_000_000_000
          let stringFormatted = formatted.asNumberString()
          return "\(sign)\(stringFormatted)Tr"
      case 1_000_000_000...:
          let formatted = num / 1_000_000_000
          let stringFormatted = formatted.asNumberString()
          return "\(sign)\(stringFormatted)Bn"
      case 1_000_000...:
          let formatted = num / 1_000_000
          let stringFormatted = formatted.asNumberString()
          return "\(sign)\(stringFormatted)M"
      case 1_000...:
          let formatted = num / 1_000
          let stringFormatted = formatted.asNumberString()
          return "\(sign)\(stringFormatted)K"
      case 0...:
          return self.asNumberString()

      default:
          return "\(sign)\(self)"
      }
  }
}

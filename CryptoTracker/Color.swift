//
//  Color.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 14.04.22.
//

import SwiftUI

extension Color{
  static let colorTheme = ColorTheme()
}

struct ColorTheme {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}

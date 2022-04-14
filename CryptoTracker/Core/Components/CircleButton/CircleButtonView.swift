//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 14.04.22.
//

import SwiftUI

struct CircleButtonView: View {
  
  var iconName: String
  
  var body: some View {
    Image(systemName: iconName)
      .font(.headline)
      .foregroundColor(Color.colorTheme.accent)
      .frame(width: 50, height: 50)
      .background(Circle()
        .foregroundColor(.colorTheme.background))
      .shadow(color: .colorTheme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
      .padding()
  }
}

struct CircleButtonView_Previews: PreviewProvider {
  static var previews: some View {
    Group{
      CircleButtonView(iconName: "plus")
        .previewLayout(.sizeThatFits)
      
      CircleButtonView(iconName: "info")
        .previewLayout(.sizeThatFits)
        .colorScheme(.dark)
    }
  }
}

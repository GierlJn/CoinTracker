//
//  XDismissButton.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 19.04.22.
//

import SwiftUI

struct XDismissButton: View {
  
  @Environment(\.dismiss) private var dismiss

    var body: some View {
      Button {
        dismiss()
      } label: {
        Image(systemName: "xmark")
          .font(.headline)
      }
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton()
    }
}

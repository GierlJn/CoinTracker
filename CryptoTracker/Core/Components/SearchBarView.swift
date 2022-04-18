//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 18.04.22.
//

import SwiftUI

struct SearchBarView: View {
  
  @Binding var input: String
  
    var body: some View {
      HStack{
        Image(systemName: "magnifyingglass")
          .foregroundColor(Color.colorTheme.accent)
        TextField("Search coin", text: $input)
          .overlay(alignment: .trailing){
            Image(systemName: "xmark.circle.fill")
              .foregroundColor(Color.colorTheme.accent)
              .opacity(input.isEmpty ? 0 : 1)
              .padding()
              .onTapGesture {
                input = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
              }
          }
        
      }
      .font(.headline)
      .padding()
      .background{
        RoundedRectangle(cornerRadius: 20)
          .fill(Color.colorTheme.background)
          .shadow(color: Color.colorTheme.secondaryText, radius: 20)
      }
    }
}

struct SearchBarViewPreview: View{
  @State var input: String = ""
  var body: some View{
    SearchBarView(input: $input)
  }
}

struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
      Group{
        SearchBarViewPreview()
          .previewLayout(.sizeThatFits)
        
        SearchBarViewPreview()
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
      
    }
}

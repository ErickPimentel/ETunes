//
//  SearchPlaceholderView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct SearchPlaceholderView: View {
    @Binding var searchTerm: String
    let suggestions = ["The Eminem Show", "Dangerous", "Highlights"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self){ text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title3)
                }
                
            }
        }
    }
}


struct SearchPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceholderView(searchTerm: .constant("John"))
    }
}

//
//  ImageLoadingView.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/25/22.
//

import SwiftUI

struct ImageLoadingView: View {
    
    let urlString: String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)){ image in
            image.resizable()
                .border(Color(white: 0.8))
        } placeholder: {
            ProgressView()
        }
        .frame(width: size, height: size)
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(urlString: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/60x60bb.jpg", size: 60)
    }
}

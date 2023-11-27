//
//  GalleryHeroHeader.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import SwiftUI

struct GalleryHeroHeader: View {
    var palettes: [Palette]
    @Binding var mainID: Palette.ID?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            Text("Featured")
            Spacer().frame(maxWidth: .infinity)
        }
        .padding(.horizontal, hMargin)
    }
    
    var hMargin: CGFloat {
        20.0
    }
}

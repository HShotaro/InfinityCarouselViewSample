//
//  GalleryHeroContent.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import SwiftUI

struct GalleryHeroContent: View {
    
    var palettes: [Palette]
    @Binding var mainID: Palette.ID?
    var columns: Int
    var tapHandler: (Palette) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: hSpacing) {
                ForEach(palettes) { palette in
                    GalleryHeroView(palette: palette, columns: columns, tapHandler: tapHandler)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, hMargin)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $mainID)
        .scrollIndicators(.never)
    }
    
    var hMargin: CGFloat {
        20.0
    }
    
    var hSpacing: CGFloat {
        // ここを0にしない場合、最初に左スクロールした時に更新されるmainIDの値が異なってしまうので注意する
        0.0
    }
}

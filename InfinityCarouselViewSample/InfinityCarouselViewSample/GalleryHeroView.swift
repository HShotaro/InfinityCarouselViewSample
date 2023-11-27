//
//  GalleryHeroView.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import SwiftUI

struct GalleryHeroView: View {
    var palette: Palette
    var columns: Int
    var tapHandler: (Palette) -> Void
    
    var body: some View {
        colorStack
            .onTapGesture {
                tapHandler(palette)
            }
            .aspectRatio(heroRatio, contentMode: .fit)
            .containerRelativeFrame(
                [.horizontal], count: columns, spacing: hSpacing
            )
            .clipShape(.rect(cornerRadius: 20.0))
            .scrollTransition(axis: .horizontal) { content, phase in
                content
                    .scaleEffect(
                        x: phase.isIdentity ? 1.0 : 0.6,
                        y: phase.isIdentity ? 1.0 : 0.6)
                    .hueRotation(.degrees(45 * phase.value))
                    .rotationEffect(.degrees(90 * phase.value))
            }
    }
    
    @ViewBuilder
    private var colorStack: some View {
        let offsetValue = stackPadding
        ZStack {
            Color.red
                .offset(x: offsetValue, y: offsetValue)
            Color.blue
            Color.green
                .offset(x: -offsetValue, y: -offsetValue)
                .overlay {
                    Text(palette.number.description)
                        .foregroundColor(.white)
                        .font(.headline)
                }
        }
        .padding(stackPadding)
        .background()
    }
    
    var stackPadding: CGFloat {
        20.0
    }
    
    var heroRatio: CGFloat {
        16.0 / 9.0
    }
    
    var hSpacing: CGFloat {
        0.0
    }
}

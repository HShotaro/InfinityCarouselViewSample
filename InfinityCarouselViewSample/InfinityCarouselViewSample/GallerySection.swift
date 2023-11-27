//
//  GallerySection.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import SwiftUI

struct GallerySection<Content: View, Label: View>: View {
    var edge: Edge? = nil
    @ViewBuilder var content: Content
    @ViewBuilder var label: Label
    
    var body: some View {
        VStack(alignment: .leading) {
            label
                .font(.title2.bold())
            content
        }
        .padding(.top, halfSpacing)
        .padding(.bottom, sectionSpacing)
        .overlay(alignment: .bottom) {
            if edge != .bottom {
                Divider().padding(.horizontal, hMargin)
            }
        }
    }
    var halfSpacing: CGFloat {
        sectionSpacing / 2.0
    }
    
    var sectionSpacing: CGFloat {
        20.0
    }
    
    var hMargin: CGFloat {
        20.0
    }
}

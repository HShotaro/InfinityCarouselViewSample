//
//  ContentView.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GalleryHeroSection(viewModel: GalleryHeroSectionViewModel(palettes: Palette.createPalettes()))
    }
}

#Preview {
    ContentView()
}

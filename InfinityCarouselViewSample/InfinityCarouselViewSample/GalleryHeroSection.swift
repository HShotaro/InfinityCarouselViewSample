//
//  GalleryHeroSection.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import SwiftUI

struct GalleryHeroSection: View {
    @StateObject var viewModel: GalleryHeroSectionViewModel
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack {
                ScrollView {
                    GallerySection(edge: .top) {
                        GalleryHeroContent(palettes: viewModel.palettes, mainID: $viewModel.mainID, columns: viewModel.columns, tapHandler: viewModel.didTapItem(palette:))
                    } label: {
                        GalleryHeroHeader(palettes: viewModel.palettes, mainID: $viewModel.mainID)
                    }
                    .onChange(of: viewModel.mainID) { oldValue, newValue in
                        viewModel.didChangeMainID(newValue: newValue, oldValue: oldValue)
                    }.onChange(of: sizeClass) { _, newValue in
                        viewModel.didChangeSizeClass(newValue)
                    }
                    .onAppear {
                        viewModel.onAppearCalled(sizeClass: sizeClass)
                    }
                    .onDisappear {
                        viewModel.onDisappearCalled()
                    }
                }
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavigationPathType.self) { path in
                switch path {
                case .paletteDetail(let palette):
                    Text(palette.name)
                }
            }
        }
    }
}

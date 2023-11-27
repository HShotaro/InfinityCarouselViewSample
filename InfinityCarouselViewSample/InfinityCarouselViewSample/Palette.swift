//
//  Palette.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import Foundation

struct Palette: Identifiable, Hashable {
    var id: UUID
    var number: Int
    var name: String
    
    static func createPalettes() -> [Palette] {
        [
            .init(id: UUID(), number: 1, name: "Example One"),
            .init(id: UUID(), number: 2, name: "Example Two"),
            .init(id: UUID(), number: 3, name: "Example Three"),
            .init(id: UUID(), number: 4, name: "Example Four"),
            .init(id: UUID(), number: 5, name: "Example Five"),
            .init(id: UUID(), number: 6, name: "Example Six"),
            .init(id: UUID(), number: 7, name: "Example Seven"),
            .init(id: UUID(), number: 8, name: "Example Eight"),
            .init(id: UUID(), number: 9, name: "Example Nine"),
        ]
    }
}

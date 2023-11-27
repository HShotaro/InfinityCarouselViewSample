//
//  GalleryHeroSectionViewModel.swift
//  InfinityCarouselViewSample
//
//  Created by shotaro hirano on 2023/11/28.
//

import SwiftUI
import Combine

class GalleryHeroSectionViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var palettes: [Palette]
    @Published var mainID: Palette.ID?
    @Published var columns: Int
    
    private var timerCancellable: AnyCancellable?
    private let didChangeMainIDSubject = PassthroughSubject<Palette.ID?, Never>()
    
    init(palettes: [Palette], mainID: Palette.ID? = nil, columns: Int = 1) {
        self.palettes = palettes
        self.mainID = mainID
        self.columns = columns
    }
    
    private func setUpTimerSubscription() {
        timerCancellable = didChangeMainIDSubject.eraseToAnyPublisher()
            .map { _ in return }
            .merge(with: Timer.publish(every: 10, on: .main, in: .default)
                .autoconnect()
                .share()
                .map { _ in return }
                .eraseToAnyPublisher())
            .debounce(for: .seconds(9), scheduler: DispatchQueue.main)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] _ in
                    self?.timerCancellable = nil
                }, receiveValue: { [weak self] _ in
                    guard let self else {
                        return
                    }
                    guard let currentIndex = self.palettes.firstIndex(where: { $0.id == (self.mainID ?? self.palettes.first?.id )}),
                          currentIndex + 1 < palettes.count
                    else {
                        return
                    }
                    print(Int(Date().timeIntervalSince1970))
                    withAnimation {
                        self.mainID = self.palettes[currentIndex + 1].id
                    }
                })
    }
    
    private func resetPalettes() {
        let newPalettes = Palette.createPalettes()
        palettes = newPalettes
        mainID = newPalettes.first?.id
    }
    
    func onAppearCalled(sizeClass: UserInterfaceSizeClass?) {
        didChangeSizeClass(sizeClass)
        setUpTimerSubscription()
    }
    
    func onDisappearCalled() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func didChangeMainID(newValue: Palette.ID?, oldValue: Palette.ID?) {
        guard oldValue != newValue else {
            return
        }
        if newValue == palettes.first?.id {
            palettes.insert(contentsOf: Palette.createPalettes(), at: 0)
        } else if palettes.count > 1, newValue == palettes[palettes.count - columns].id {
            palettes.append(contentsOf: Palette.createPalettes())
        }
        didChangeMainIDSubject.send(newValue)
    }
    
    func didChangeSizeClass(_ sizeClass: UserInterfaceSizeClass?) {
        columns = sizeClass == .compact ? 1 : 2
    }
    
    func didTapItem(palette: Palette) {
        navigationPath.append(NavigationPathType.paletteDetail(palette: palette))
        resetPalettes()
    }
}

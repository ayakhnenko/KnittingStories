//
//  NavigationStorage.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 06.03.2023.
//



import SwiftUI

/// Хранилище стека
final class NavigationStorage: ObservableObject {
    
    static let shared = NavigationStorage()
    
    /// Хранение стека навигации
  // @Published var pathItem = [NavigationPathItem]()
@Published var path = NavigationPath()

    func show(id: String, title: String, destination: @escaping () -> some View) {
        let item = NavigationPathItem(id: id, title: title) {
            AnyView(destination())
        }
        item.isShown = true

        path.append(item)
    }
    
   
//    func popToRoot() {
//        UIApplication.enableKeyWindowAnimation()
//        path.removeLast(path.count)
//    }
//
//    func popTo(index: Int) {
//        guard !path.isEmpty, index < path.count else { return }
//        UIApplication.enableKeyWindowAnimation()
//        path.removeLast(path.count - index)
//    }
}

//
//  NavigationPathItem.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 06.03.2023.
//


import SwiftUI

/// Информация об экранах навигации
final class NavigationPathItem: Identifiable, Hashable {

    /// Идентификатор
    let id: String
    /// Название экрана
    let title: String?
    
    var isShown: Bool
    
    var destination: () -> AnyView

    init(id: String, title: String, isShown: Bool = false, destination: @escaping () -> AnyView) {
        self.id = id
        self.title = title
        self.isShown = isShown
        self.destination = destination
    }
    
    static func == (lhs: NavigationPathItem, rhs: NavigationPathItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

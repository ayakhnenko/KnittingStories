//
//  Button + Extension.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 30.01.2023.
//

import Foundation
import SwiftUI

extension Button {
    
    var buttonModif: some View {
        return self
            .padding()
            .background(Color.yellow)
            .foregroundColor(.gray)
            .textFieldStyle(.roundedBorder)
            .cornerRadius(20)
    }
}

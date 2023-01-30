//
//  Image + Extension.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 30.01.2023.
//

import Foundation
import SwiftUI

extension Image {
    
    var bigCircle: some View {
        return self
            .resizable()
            .scaledToFit()
            .edgesIgnoringSafeArea(.all)
            .clipShape(Circle())
            .frame(width: 90, height: 90)
            .shadow(radius: 10)
            .padding(10)
    }
       
    var smallCircle: some View {
        return self
            .resizable()
            .scaledToFit()
            .edgesIgnoringSafeArea(.all)
            .clipShape(Circle())
            .frame(width: 60, height: 60)
            .shadow(radius: 10)
            .overlay(Circle()
                .stroke(Color.gray, lineWidth: 2))
            //.padding(15)
    }
}

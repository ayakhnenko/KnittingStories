//
//  Date + Extension.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 01.02.2023.
//

import Foundation
import SwiftUI

extension Date {
    
    func dateFormatter() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "dd-MM-yy"
        
        let toString = dateFormatter.string(from: self)
        return toString
    }
    
    func dateYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "YYYY"
        let yearToString = dateFormatter.string(from: self)
        return yearToString
    }
}


extension Double {
    
    func roundToPlaces() -> String {
        let aStr = String(format: "%05.2f", self)
        return aStr
    }
}

//extension View {
//    static var navigationID: String {
//        String(describing: self)
//    }
//}

extension Image {
    
    
    var bigCircle: some View {
        return self
            
            .resizable()
            .scaledToFit()
            .edgesIgnoringSafeArea(.all)
            .clipShape(Circle())
            .frame(width: 130, height: 130)
            .shadow(radius: 10)
            .clipped()
            .padding(10)
        
    }
       
    var smallCircle: some View {
        return self
            .resizable()
            .scaledToFit()
            .edgesIgnoringSafeArea(.all)
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .shadow(radius: 10)
            .clipped()
            //.padding(15)
    }
    
    var smallProjPhoto: some View {
        return self
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 130, height: 130)
            .padding()
        
    }
    var bigProjPhoto: some View {
        return self
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 250, height: 250)
            .padding()
    }
    
  
}

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

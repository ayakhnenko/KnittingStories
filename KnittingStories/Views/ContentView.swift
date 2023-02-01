//
//  ContentView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc

    
    @State private var selectedView = 1
    var body: some View {
        
        TabView(selection: $selectedView) {
            YarnList()
                .tabItem {
                        Text("Пряжа🧶")
                }.tag(1)
                
            ProjectList()
                .tabItem {
                        Text("Вироби🧣")
                }.tag(2)
            
            ArchivedYarnListView()
                .tabItem {
                    Text("Архів пряжі🗄")
                }.tag(3)
            SoldProjectListView()
                .tabItem {
                    Text("Продані вироби💵")
                }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

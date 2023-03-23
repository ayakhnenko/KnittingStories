//
//  ContentView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    let views = ["Пряжа", "Вироби", "Архів пряжі", "Продані вироби", "Вироби на продаж"]
    
    @State private var selectedView: Int = 0
    
    var body: some View {
        VStack {
            
            Picker(selection: $selectedView, label: Text("")) {
                ForEach(0..<5) { view in
                    Text(self.views[view])
                    
                }
           }.pickerStyle(SegmentedPickerStyle())
            
//            Picker(selection: $selectedView, label: Text("")) {
//                ForEach(3..<5) { view in
//                    Text(self.views[view])
//
//                }
//           }.pickerStyle(SegmentedPickerStyle())
//
            
            if selectedView == 0 {
                YarnList(vm: YarnListViewModel(context: viewContext))
            }
            else if selectedView == 1 {
                ProjectList(vm: ProjectListViewModel(context: viewContext))
            }
            else if selectedView == 2 {
                ArchivedYarnListView(vm: YarnListViewModel(context: viewContext))
            }
            else if selectedView == 3 {
                SoldProjectListView(vm: ProjectListViewModel(context: viewContext))
            }
            else  {
                ProjectOnSaleView(vm: ProjectListViewModel(context: viewContext))
            }
        }
//        TabView(selection: $selectedView) {
//            YarnList(vm: YarnListViewModel(context: viewContext))
//                .tabItem {
//                    Label("Пряжа🧶", systemImage: "")
//                }.tag(1)
//
//            ProjectList(vm: ProjectListViewModel(context: viewContext))
//                .tabItem {
//                    Text("Вироби🧣")
//                }.tag(2)
//
//            ArchivedYarnListView(vm: YarnListViewModel(context: viewContext))
//                .tabItem {
//                    Text("Архів пряжі🗄")
//                }.tag(3)
//            SoldProjectListView(vm: SoldProjectListViewModel(context: viewContext))
//                .tabItem {
//                    Text("Продані вироби💵")
//                }.tag(4)
//            ProjectOnSaleView(vm: OnSaleProjectListViewModel(context: viewContext))
//                .tabItem {
//                    Text("Вироби на продаж")
//                }.tag(5)
//
            
        //}
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       // let viewContext = DataController.shared.container.viewContext
        ContentView()
        
    }
}

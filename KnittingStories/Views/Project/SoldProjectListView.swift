//
//  SoldProjectListView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 01.02.2023.
//

import SwiftUI

struct SoldProjectListView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @StateObject private var storage = NavigationStorage.shared
    @ObservedObject var vm: ProjectListViewModel
    
    
    init(vm: ProjectListViewModel) {
        self.vm = vm
    }
    var body: some View {
        NavigationStack(path: $storage.path) {
            
            List {
                Section {
                    ForEach(vm.arrayYears, id: \.self) { year in
                        Text("\(year) рік")
                        ForEach(vm.sold, id: \.self) { project in
                            if project.saleDate.dateYear() == year {
                                Button {
                                    vm.selectModelIntent(project: project)
                                }
                            label: {
                                HStack {
                                    Image(uiImage: project.image)
                                        .smallProjPhoto
                                    VStack {
                                        Text(project.name).bold()
                                        Text("\(project.saleCost.roundToPlaces()) грн")
                                    }
                                    
                                    Text(project.saleDate.dateFormatter())
                                }
                            }
                            }
                        }
                    }
                }
            }.listStyle(.plain)
                .navigationDestination(for: ProjectModel.self) {
                    [weak vm] project in
                    if let detailProjectViewModel = vm?.detailProjectViewModel {
                        ProjectView(vm: detailProjectViewModel)
                    }
                }
                .navigationTitle("Продані вироби")
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    EditButton()
            //                }
            //            }
            //            .sheet(isPresented: $showingAddProject) {
            //                AddProjectView()
            //            }
        }
        .navigationViewStyle(.stack)
        
    }
    
}

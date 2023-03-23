//
//  ProjectOnSaleView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 08.03.2023.
//

import SwiftUI


struct ProjectOnSaleView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @StateObject private var storage = NavigationStorage.shared
    @ObservedObject var vm: ProjectListViewModel
    
    
    init(vm: ProjectListViewModel) {
        self.vm = vm
    }
    var body: some View {
        NavigationStack(path: $storage.path) {
            
            List {
                ForEach(vm.onSale, id: \.self) { project in
                    Button {
                        vm.selectModelIntent(project: project)
                    }
                label: {
                    HStack {
                        Image(uiImage: project.image)
                            .smallProjPhoto
                        Text("\(project.name)")
                    }
                    
                }
                }
                //.onDelete(perform: deleteProject)
            }.listStyle(.plain)
                .navigationDestination(for: ProjectModel.self) {
                    [weak vm] project in
                    if let detailProjectViewModel = vm?.detailProjectViewModel {
                        ProjectView(vm: detailProjectViewModel)
                    }
                }
                .navigationTitle("Вироби на продаж")
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

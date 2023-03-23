//
//  ProjectList.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

 import SwiftUI
import CoreData

struct ProjectList: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @StateObject private var storage = NavigationStorage.shared
    @ObservedObject var vm: ProjectListViewModel
    @State private var showingAddProject = false
    
    
    
    init(vm: ProjectListViewModel) {
        self.vm = vm
    }
    
    private func deleteProject(offsets: IndexSet) {
        offsets.forEach { index in
            let project = vm.projects[index]
            vm.deleteProject(projectId: project.id)
        }
        
    }
    
    var body: some View {
        NavigationStack(path: $storage.path) {
            
            List {
                Section {
                    ForEach(vm.arrayYears, id: \.self) { year in
                        Text("\(year) рік")
                        ForEach(vm.projects, id: \.self) { project in
                            if project.finishDate.dateYear() == year {
                                Button {
                                    vm.selectModelIntent(project: project)
                                } label: {
                                    HStack {
                                        Image(uiImage: project.image)
                                            .smallProjPhoto
                                        VStack(alignment: .leading) {
                                            Text("\(project.name)")
                                            HStack {
                                                Text(project.startDate.dateFormatter())
                                                Text(" - ")
                                                Text(project.finishDate.dateFormatter())
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }.onDelete(perform: deleteProject)
                    }
                }
                }.listStyle(.plain)
                    .navigationDestination(for: ProjectModel.self) { [weak vm] project in
                        if let detailProjectViewModel = vm?.detailProjectViewModel {
                            ProjectView(vm: detailProjectViewModel)
                        }
                    }
            }
                    .navigationTitle("Вироби")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showingAddProject.toggle()
                            } label: {
                                Label("Add project", systemImage: "plus.circle")
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                        }
                        
                    }
                    .sheet(isPresented: $showingAddProject) {
                        AddProjectView(vm: DetailProjectViewModel(context: viewContext, parent: self.vm))
                        
                    }
        
            .navigationViewStyle(.stack)
            
        }
        
    }



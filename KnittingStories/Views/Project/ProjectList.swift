//
//  ProjectList.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI

struct ProjectList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.finishDate, order: .reverse)]) var projects: FetchedResults<Project>
    
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.name], predicate: NSPredicate(format: "forSale == %@", "true" )) var projectForSale: FetchedResults<Project>
    
    @State private var showingAddProject = false
    @State private var image = UIImage(imageLiteralResourceName: "llama")
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(projects) { project in
                        NavigationLink {
                            ProjectView(project: project)
                        }
                    label: {
                            HStack {
                                Image(uiImage: UIImage(data: project.image!) ?? UIImage(imageLiteralResourceName: "llama"))
                                    .smallCircle
                                
                                Text("\(project.wrappedName)")
                            }
                            
                        }
                    }
                    .onDelete(perform: deleteProject)
                }.listStyle(.plain)
            }
            .navigationTitle("Project")
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
                AddProjectView()
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            offsets.map { projects[$0] }.forEach(moc.delete)
            DataController().save(context: moc)
        }
    }
    
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}

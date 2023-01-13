//
//  ProjectList.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI

struct ProjectList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.finishDate, order: .reverse)]) var project: FetchedResults<Project>
    
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.name], predicate: NSPredicate(format: "forSale == %@", "true" )) var projectForSale: FetchedResults<Project>
    
    @State private var showingAddProject = false

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(project) { project in
                        NavigationLink {
                            ProjectView(project: project)
                        }
                    label: {
                            HStack {
                                Image(uiImage: UIImage(data: project.image!) ?? UIImage(imageLiteralResourceName: "llama"))
                                    .resizable()
                                    .scaledToFit()
                                    .edgesIgnoringSafeArea(.all)
                                    .clipShape(Circle())
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 10)
                                
                                Text("\(project.name!)")
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
            offsets.map { project[$0] }.forEach(moc.delete)
            DataController().save(context: moc)
        }
    }
    
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}

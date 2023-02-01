//
//  SoldProjectListView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 01.02.2023.
//

import SwiftUI

struct SoldProjectListView: View {
    
   @Environment(\.managedObjectContext) var moc
   @FetchRequest(sortDescriptors: [SortDescriptor(\.finishDate, order: .reverse)], predicate: NSPredicate(format: "sold == true")) var projects: FetchedResults<Project>
                                   
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
            .navigationTitle("Вироби")
            .toolbar {
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
                                    
                                    
    struct SoldProjectListView_Previews: PreviewProvider {
        static var previews: some View {
            SoldProjectListView()
        }
    }

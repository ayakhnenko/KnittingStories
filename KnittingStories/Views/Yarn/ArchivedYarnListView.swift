//
//  ArchivedYarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 01.02.2023.
//

import SwiftUI



struct ArchivedYarnListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isArchived == true")) var yarn: FetchedResults<Yarn>
    
    
    @State private var showingAddYarn = false
    
    var body: some View {
        
        NavigationView {
            VStack {
        List {
            ForEach(yarn) { yarn in
                NavigationLink(destination: YarnView(yarn: yarn)) {
                    HStack {
                        Image(uiImage: UIImage(data: yarn.image!)!)
                            .smallCircle
                       
                        Text(yarn.wrappedName)
                        Spacer()
                        Text(" - \(yarn.calcCurrentWeight())г")
                    }
                }
                
            }
            .onDelete(perform: deleteYarn)
            
        }.listStyle(.plain)
            }
            .navigationTitle("Архів пряжі")
            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        showingAddYarn.toggle()
//                    } label: {
//                        Label("Add yarn", systemImage: "plus.circle")
//                    }
//                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddYarn) {
                AddYarnView()
            }
    }
        .navigationViewStyle(.stack)
        
       
}
    
    private func deleteYarn(offsets: IndexSet) {
        withAnimation {
            offsets.map { yarn[$0] }.forEach(moc.delete)
            DataController().save(context: moc)
        }
    }
}



struct ArchivedYarnListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedYarnListView()
    }
}

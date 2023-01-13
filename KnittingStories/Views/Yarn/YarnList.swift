//
//  YarnList.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI

struct YarnList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var yarn: FetchedResults<Yarn>

    
    @State private var showingAddYarn = false
    
    var body: some View {
        
        NavigationView {
            VStack {
        List {
            ForEach(yarn) { yarn in
                NavigationLink(destination: YarnView(yarn: yarn)) {
                    HStack {
                        Image(uiImage: UIImage(data: yarn.image!)!)
                            .resizable()
                            .scaledToFit()
                            .edgesIgnoringSafeArea(.all)
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .shadow(radius: 10)
//                            .overlay(Circle()
//                                .stroke(Color.gray, lineWidth: 2))
//                
                        Text(yarn.name ?? "шо-то там...")
                        Spacer()
                        Text(" - \(yarn.originalWeight)г")
                    }
                }
                
            }
            .onDelete(perform: deleteYarn)
            
        }.listStyle(.plain)
            }
            .navigationTitle("Yarn")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddYarn.toggle()
                    } label: {
                        Label("Add yarn", systemImage: "plus.circle")
                    }
                }
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


struct YarnList_Previews: PreviewProvider {
    static var previews: some View {
        YarnList()
    }
}

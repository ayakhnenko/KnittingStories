//
//  ArchivedYarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 01.02.2023.
//

import SwiftUI



struct ArchivedYarnListView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var vm: YarnListViewModel
    @StateObject private var storage = NavigationStorage.shared
    @State private var showingAddYarn = false
    
    init(vm: YarnListViewModel) {
        self.vm = vm
    }
    

    var body: some View {
        
        NavigationStack(path: $storage.path) {
            
            List {
                ForEach(vm.archivedYarns, id: \.self) { yarn in
                    Button {
                        vm.selectModelIntent(yarn: yarn)
                    } label: {
                        HStack {
                            Image(uiImage: yarn.image)
                                .smallCircle
                            Text(yarn.name)
                            Spacer()
                            Text(" - \(yarn.yarn.calcCurrentWeight())г")
                        }
                    }
                    
                }
                //.onDelete(perform: deleteYarn)
                
            }.listStyle(.plain)
                .navigationDestination(for: YarnModel.self) {
                    [weak vm] yarn in
                    if let detailYarnViewModel = vm?.detailYarnViewModel {
                        YarnView(vm: detailYarnViewModel)
                    }
                }
                .navigationTitle("Архів пряжі")
                
            //            .sheet(isPresented: $showingAddYarn) {
            //                AddYarnView()
            //            }
        }
        .navigationViewStyle(.stack)
        
    }
}
    
//    private func deleteYarn(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { yarn[$0] }.forEach(moc.delete)
//            DataController().save(context: moc)
//        }
//    }




//struct ArchivedYarnListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = DataController.shared.container.viewContext
//        ArchivedYarnListView(vm: ArchivedYarnListViewModel(context: viewContext)
//    }
//}

//
//  YarnList.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI
import CoreData

struct YarnList: View {
    
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var vm: YarnListViewModel
    @State private var showingAddYarn = false
    @StateObject private var storage = NavigationStorage.shared
    
    
   init(vm: YarnListViewModel) {
        self.vm = vm
  }

    private func deleteYarn(at offsets: IndexSet) {
        offsets.forEach { index in
            let yarn = vm.yarns[index]
            vm.deleteYarn(yarnId: yarn.id)
        }
    }
    
    var body: some View {
    
        NavigationStack(path: $storage.path) {
            List {
                Section {
                    ForEach(vm.arrayYears, id: \.self) { year in
                        Text("\(year) рік")
                        ForEach(vm.yarnInStock, id: \.self) { yarn in
                            if yarn.date.dateYear() == year {
                                Button {
                                    vm.selectModelIntent(yarn: yarn)
                                } label: {
                                    HStack {
                                        Image(uiImage: yarn.image)
                                            .smallCircle
                                        VStack {
                                            Text(yarn.name)
                                            Text(yarn.date.dateFormatter())
                                        }
                                        Spacer()
                                        Text(yarn.currentWeight.roundToPlaces())
                                    }
                                }
                            }
                            
                        }.onDelete(perform: deleteYarn)
                    }
                }
        }.listStyle(.plain)
            .navigationDestination(for: YarnModel.self) { [weak vm] yarn in
                    if let detailYarnViewModel = vm?.detailYarnViewModel {
                        YarnView(vm: detailYarnViewModel)
                    }
                }
            .navigationTitle("Пряжа")
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
                AddYarnView(vm: DetailYarnViewModel(context: viewContext, parent: self.vm))
                
            }
            .navigationViewStyle(.stack)
        }
    }
}


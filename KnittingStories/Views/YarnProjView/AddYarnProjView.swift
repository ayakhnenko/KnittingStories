//
//  SwiftUIView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 12.12.2022.
//

import SwiftUI

struct AddYarnProjView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    
    @ObservedObject var vm: YarnProjViewModel
    
    init(vm: YarnProjViewModel) {
        self.vm = vm
        
    }
    
    @State private var showingAlert = false
    @State private var showingYarnList = false
    @State private var showingProjectList = false
    
    var body: some View {
        
        List {
            
            ForEach(vm.yarns, id: \.self) { yarn in
                Button {
                   // yarnProjVM.yarnListViewModel?.selectModelIntent(yarn: yarn)
                    vm.selectModelIntent(yarn: yarn)
                } label: {
                    HStack {
                        Image(uiImage: yarn.image)
                            .smallCircle
                        Text(yarn.name)
                        Spacer()
                        Text("\(yarn.currentWeight)")
                    }
                    .onTapGesture {
                        vm.fromYarn = yarn.yarn
                        showingAlert.toggle()
                    }
                }
            }.navigationDestination(for: YarnModel.self) { [weak vm] yarn in
                if let yarnListViewModel = vm?.yarnListViewModel {
                    YarnList(vm: yarnListViewModel)
                }
            }
            .alert("Кількість пряжі", isPresented: $showingAlert) {
                
                TextField("", value: $vm.yarnWeightInProj, formatter: NumberFormatter())
                
                Button("Ok") {
                    vm.addYarnProj(fromYarn: vm.fromYarn!, fromProj: vm.fromProj, yarnWeightInProj: vm.yarnWeightInProj)
                    
                    self.dismiss()
                    
                }
            }
            
        }
        
    }
}

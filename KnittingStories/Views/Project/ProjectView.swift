//
//  ProjectView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 14.11.2022.
//

import SwiftUI

 struct ProjectView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
     @StateObject private var storage = NavigationStorage.shared
     @ObservedObject var vm: DetailProjectViewModel
     
     @State private var showingEditProject = false
     
     init(vm: DetailProjectViewModel) {
         self.vm = vm
     }

    var body: some View {
            Form {
                HStack {
                    Spacer()
                    Image(uiImage: vm.project!.image)
                        .bigProjPhoto
                        .onAppear {
                            vm.image =  vm.project!.image
                            //vm.dismiss()
                        }
                    Spacer()
                }
                Section {
                    Text("Загальні параметри")
                        .bold()
                        .foregroundColor(.blue)
                    Text("Назва: \(vm.project!.name)")
                    Text("Загальна вага,(г): \(vm.project!.totalWeight.roundToPlaces())")
                    Text("Початок: \(vm.startDate.dateFormatter())")
                        .onAppear {
                            vm.startDate = vm.project!.startDate
                        }
                    Text("Кінець: \(vm.finishDate.dateFormatter())")
                        .onAppear {
                            vm.finishDate = vm.project!.finishDate
                        }
                    Text("Розмір виробу: \(vm.project!.size)")
                    Text("Розмір спиць: \(vm.project!.needlesNumber)")
                    Text("Собівартість виробу,(грн): \(vm.project!.project.cost.roundToPlaces())")
                    
                }
                Section {
                    Text("Пряжа")
                        .bold()
                        .foregroundColor(.mint)
                    List {
                        ForEach(vm.project!.project.yarnForProjectArray) { yarnProj in
                            HStack {
                                Image(uiImage: UIImage(data: (yarnProj.fromYarn!.image)!) ?? UIImage(imageLiteralResourceName: "llama"))
                                    .smallCircle
                                Text(yarnProj.fromYarn!.name!)
                                Text("\(yarnProj.yarnWeightInProj.roundToPlaces()) г")
                            }
                            
                        }
                    }
                }
                if vm.project!.project.forSale {
                    Text("На продаж")
                }
                if vm.project!.project.sold {
                    Section {
                        Text("Параметри для продажу")
                            .bold()
                            .foregroundColor(.blue)
                        Text("Маркетплейс: \(vm.project!.project.marketplace ?? "")")
                        Text("Комісія,(грн): \(vm.project!.project.comission.roundToPlaces())")
                        Text("Дата продажу: \(vm.saleDate.dateFormatter())")
                            .onAppear {
                                vm.saleDate = vm.project!.project.saleDate ?? Date()
                            }
                        Text("Вартість доставки,(грн): \(vm.project!.project.deliveryCost.roundToPlaces())")
                        Text("Загальні витрати,(грн): \(vm.project!.project.additExpense.roundToPlaces())")
                        Text("Ціна виробу: \(vm.project!.project.saleCost.roundToPlaces())")
                        Text("Прибуток,(грн): \(vm.project!.project.margin.roundToPlaces())")
                   }
                }
        }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingEditProject.toggle()
                    } label: {
                        Text("Edit")
                    }
                }
            
        }.sheet(isPresented: $showingEditProject) {
            EditProjectView(vm: self.vm)
                                
        }
        }
    }


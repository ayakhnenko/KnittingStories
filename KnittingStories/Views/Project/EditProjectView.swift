//
//  EditProjectView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 18.10.2022.
//

import SwiftUI

struct EditProjectView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    @StateObject private var storage = NavigationStorage.shared
   
    @ObservedObject var vm: DetailProjectViewModel
    
    init(vm: DetailProjectViewModel) {
        self.vm = vm
    }
    
    @State private var showYarnProjView = false
    @State private var imagePicker = false
   
    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {
                        Image(uiImage: vm.project!.image)
                            .smallProjPhoto
                            .onAppear {
                                vm.image = vm.project!.image
                            }
                        
                        Button {
                            imagePicker.toggle()
                        } label: {
                            Text("Змінити світлину")
                        }
                        .sheet(isPresented: $imagePicker) {
                            ImagePickerView(selectedImage: $vm.image)
                        }
                    }
                    HStack {
                        Text("Назва:")
                        TextField(vm.project!.name, text: $vm.name)
                            .onAppear {
                                vm.name = vm.project!.name
                            }
                    }
                    .padding(.horizontal, 6)
                    .textFieldStyle(.roundedBorder)
                    HStack {
                        Text("Загальна вага")
                        TextField(String(vm.project!.totalWeight), value: $vm.totalWeight, formatter: NumberFormatter())
                            .onAppear {
                                vm.totalWeight = vm.project!.totalWeight
                            }
                    }
                    HStack {
                        Text("Розмір виробу:")
                        TextField(vm.project!.size, text: $vm.size)
                            .onAppear {
                                vm.size = vm.project!.size
                            }
                    }
                }
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
                            Text(yarnProj.fromYarn!.wrappedName)
                            Text("\(yarnProj.yarnWeightInProj) г")
                        }
                        
                    }
                }
                Button("Обрати пряжу") {
                    showYarnProjView.toggle()
                    
                
                    
                }.sheet(isPresented: $showYarnProjView) {
                    AddYarnProjView(vm: YarnProjViewModel(context: viewContext, fromProj: vm.project!.project, parent: self.vm))
                }
           }
            
            Section {
                VStack {
                    Text("Деталі процесу")
                    VStack {
                        DatePicker("Початок:", selection: $vm.startDate, displayedComponents: [.date])
                            .onAppear {
                                vm.startDate = vm.project!.startDate
                            }
                        DatePicker("Кінець:", selection: $vm.finishDate, displayedComponents: [.date])
                            .onAppear {
                                vm.finishDate = vm.project!.finishDate
                            }
                    }
                    
                    HStack {
                        Text("Розмір спиць:")
                        TextField("Number of needles", text: $vm.needlesNumber)
                            .onAppear {
                                vm.needlesNumber = vm.project!.needlesNumber
                            }
                    }
                    HStack {
                        Text("Собівартість виробу: \(vm.project!.cost.roundToPlaces())")
                        Spacer()
                    }
                    
                }
                
            }
          Section {
              Toggle("На продаж", isOn: $vm.forSale)
                  .onAppear {
                      vm.forSale = vm.project!.forSale
                  }
              Toggle("Продано", isOn: $vm.sold)
                  .onAppear {
                      vm.sold = vm.project!.sold
                  }
                
            }
            if vm.sold {
                Section {
                    VStack {
                        HStack {
                            Text("Маркетплейс:")
                            TextField("Marketplace", text: $vm.marketplace)
                                .onAppear {
                                    vm.marketplace = vm.project!.marketplace
                                }
                        }
                        HStack {
                            Text("Комісія:")
                            TextField("Comission", value: $vm.comission, formatter: NumberFormatter())
                                .onAppear {
                                    vm.comission = vm.project!.comission
                                }
                        }
                        
                        DatePicker("Дата продажу:", selection: $vm.saleDate, displayedComponents: [.date])
                            .onAppear {
                                vm.saleDate = vm.project!.saleDate
                            }
                        HStack {
                            Text("Вартість доставки:")
                            TextField("Delivery cost", value: $vm.deliveryCost, formatter: NumberFormatter())
                                .onAppear {
                                    vm.deliveryCost = vm.project!.deliveryCost
                                }
                        }
                        VStack(alignment: .leading) {
                            Text("Загальні витрати: \(vm.project!.additExpense)")
                            HStack {
                                Text("Ціна виробу:")
                                TextField("Sale cost", value: $vm.saleCost, formatter: NumberFormatter())
                                    .onAppear {
                                        vm.saleCost = vm.project!.saleCost
                                    }
                            }
                            Text("Прибуток: \(vm.margin)")
                        }
                    }
                }
            }
        }
        
        Section {
            HStack {
                Spacer()
                Button("Зберегти") {
                    vm.editProject(project: vm.project!.project, name: vm.name, image: vm.image, totalWeight: vm.totalWeight, startDate: vm.startDate, finishDate: vm.finishDate, forSale: vm.forSale, sold: vm.sold, size: vm.size, needlesNumber: vm.needlesNumber, marketplace: vm.marketplace, saleDate: vm.saleDate, comission: vm.comission, deliveryCost: vm.deliveryCost, saleCost: vm.saleCost)
                    self.dismiss()
                }
                .buttonModif
                Spacer()
            }
        }
    }
    
}


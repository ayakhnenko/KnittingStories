//
//  EditYarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI

struct EditYarnView: View {
    
    @ObservedObject var vm: DetailYarnViewModel
    
    init(vm: DetailYarnViewModel) {
        self.vm = vm

    }
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var imagePicker = false
  
    
    var body: some View {
      
            Form {
                Section {
                    HStack {
                        Image(uiImage: vm.image)
                            .bigCircle
                            .onAppear {
                                vm.image = vm.yarn!.image
                            }
                         Button {
                            imagePicker.toggle()
                        } label: {
                            Text("Змінити світлину")
                        }.sheet(isPresented: $imagePicker) {
                            ImagePickerView(selectedImage: $vm.image)
                        }
                    }
                }.padding()
                Section {
                    VStack {
                        Text("Загальні параметри")
                            .bold()
                            .foregroundColor(.indigo)
                        HStack {
                            Text("Назва:")
                            TextField(vm.yarn!.name, text: $vm.name)
                                .onAppear {
                                    vm.name = vm.yarn!.name
                                }
                                
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Склад:")
                            TextField(vm.yarn!.compound, text: $vm.compound)
                                .onAppear {
                                    vm.compound = vm.yarn!.compound
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Колір:")
                            TextField(vm.yarn!.color, text: $vm.color)
                                .onAppear {
                                    vm.color = vm.yarn!.color
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                    }
                }
                Section {
                    VStack {
                        Text("Вимірювальні параметри")
                            .bold()
                            .foregroundColor(.indigo)
                        HStack {
                            Text("Загальна вага:")
                            TextField(String(vm.yarn!.originalWeight), value: $vm.originalWeight, formatter: NumberFormatter())
                                .onAppear {
                                    vm.originalWeight = vm.yarn!.originalWeight
                                }.keyboardType(.numberPad)
                        }
                        
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Поточна вага: \(vm.currentWeight)")
                            Spacer()
                        }
                        
                        HStack {
                            Text("Метрів в 100г:")
                            TextField("\(vm.yarn!.footagePer100g)", value: $vm.footagePer100g, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .onAppear {
                                    vm.footagePer100g = vm.yarn!.footagePer100g
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Ціна за 100г:")
                            TextField(String(vm.yarn!.pricePer100g), value: $vm.pricePer100g, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .onAppear {
                                    vm.pricePer100g = vm.yarn!.pricePer100g
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                    }
                }
                Section {
                    VStack {
                        Text("Деталі придбання")
                            .bold()
                            .foregroundColor(.indigo)
                        
                        HStack {
                            Text("Крамниця:")
                            TextField(vm.yarn!.shop, text: $vm.shop)
                                .onAppear {
                                    vm.shop = vm.yarn!.shop
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        DatePicker("Дата:", selection: $vm.date, displayedComponents: [.date])
                            .padding(.horizontal, 6)
                            .onAppear {
                                vm.date = vm.yarn!.date
                            }
                    }
                }
                Section {
                    VStack {
                        Text("Параметри для розрахунків")
                            .bold()
                            .foregroundColor(.indigo)
                        VStack {
                            HStack {
                                Text("Доставка, (грн):")
                                TextField(String(vm.yarn!.deliveryPrice), value: $vm.deliveryPrice, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .onAppear {
                                        vm.deliveryPrice = vm.yarn!.deliveryPrice
                                    }
                            }
                            .textFieldStyle(.roundedBorder)
                            HStack {
                                Text("Ціна за 1г,(грн): \(vm.yarn!.yarn.pricePer1g)")
                                Spacer()
                            }.padding()
                            
                            HStack {
                                Text("Загальні витрати,(грн): \(vm.yarn!.yarn.totalExpense)")
                                    .bold()
                                    .foregroundColor(.purple)
                                Spacer()
                            }
                            
                        }
                    }
                }
                Section {
                    Toggle("Перенести пряжу до архиву?", isOn: $vm.isArchived)
                        .onAppear {
                            vm.isArchived = vm.yarn!.isArchived
                        }
                  
                }
                
                Section {
                    VStack {
                        Text("Вироби")
                            .bold()
                            .foregroundColor(.purple)
                            .padding()
                        List {
                            ForEach(vm.yarn!.yarn.yarnWeightArray) { yarnProj in
                                HStack {
                                    Image(uiImage: UIImage(data: (yarnProj.fromProj?.image)!) ?? UIImage(imageLiteralResourceName: "sheep"))
                                        .smallProjPhoto
                                    Text((yarnProj.fromProj?.name)!)
                                    Text("\(yarnProj.yarnWeightInProj) г")
                                }
                            }
                            }
                        }
                    }


                HStack {
                    Spacer()
                    Button("Зберегти") {
                        
                        vm.editYarn(yarn: vm.yarn!.yarn, name: vm.name, image: vm.image, compound: vm.compound, footagePer100g: vm.footagePer100g, pricePer100g: vm.pricePer100g, deliveryPrice: vm.deliveryPrice, color: vm.color, shop: vm.shop, date: vm.date, originalWeight: vm.originalWeight, isArchived: vm.isArchived)
                        self.dismiss()
               
                    }
                    .buttonModif
                    Spacer()
                }
        }
    }
}


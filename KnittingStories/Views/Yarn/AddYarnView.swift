//
//  AddYarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 11.10.2022.
//

import SwiftUI



struct AddYarnView: View {
    
    @ObservedObject var vm: DetailYarnViewModel
    
    init(vm: DetailYarnViewModel) {
        self.vm = vm
    }

    @Environment(\.dismiss) var dismiss
    @State private var imagePicker = false
   
    
    var body: some View {
            Form {
                Section {
                    HStack {
                        Image(uiImage: vm.image)
                            .bigCircle

                        Button(action: {
                            imagePicker.toggle()
                        }, label: {
                            Text("Додати світлину")
                        })
                        .sheet(isPresented: $imagePicker) {
                            ImagePickerView(selectedImage: $vm.image)
                        }
                    }
                }
                Section {
                    VStack {
                        Text("Загальні параметри")
                            .bold()
                            .foregroundColor(.indigo)
                        HStack {
                            Text("Назва:")
                            TextField("Name", text: $vm.name)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Склад:")
                            TextEditor(text: $vm.compound)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Колір:")
                            TextField("Color", text: $vm.color)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    }
                }
                Section {
                    VStack {
                        Text("Вимірювальні параметри")
                            .bold()
                            .foregroundColor(.indigo)
                        HStack {
                            Text("Початкова вага, (г):")
                            TextField("", value: $vm.originalWeight, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            Text("Метрів у 100г:")
                            TextField("Footage per 100g", value: $vm.footagePer100g, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Ціна за 100г,(грн):")
                            TextField("Price per 100g", value: $vm.pricePer100g, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding()
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
                            TextField("Shop", text: $vm.shop)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        DatePicker("Дата:", selection: $vm.date, displayedComponents: [.date])
                            .padding()
                        HStack {
                            Text("Доставка, (грн):")
                            TextField("Delivery cost", value: $vm.deliveryPrice, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    }
                }
                Section {
                    Toggle("Перенести пряжу до архиву?", isOn: $vm.isArchived)
                  
                }
                HStack {
                    Spacer()
                    Button("Зберегти") {
                        vm.addYarn(name: vm.name, image: vm.image, compound: vm.compound, footagePer100g: vm.footagePer100g, pricePer100g: vm.pricePer100g, deliveryPrice: vm.deliveryPrice, color: vm.color, shop: vm.shop, date: vm.date, originalWeight: vm.originalWeight, isArchived: vm.isArchived)
                        self.dismiss()
                    }
                    .buttonModif
                    Spacer()
                }
            }
        }
    }


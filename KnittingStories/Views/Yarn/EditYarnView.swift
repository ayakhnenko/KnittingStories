//
//  EditYarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 09.10.2022.
//

import SwiftUI

struct EditYarnView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var yarn: FetchedResults<Yarn>.Element
    
    
    @State private var name: String = ""
    @State private var image = UIImage(imageLiteralResourceName: "sheep")
    @State private var date = Date()
    @State private var compound: String = ""
    @State private var footagePer100g: Double = 0
    @State private var originalWeight: Double = 1
    @State private var shop: String = ""
    @State private var deliveryPrice: Double = 0
    @State private var color: String = ""
    @State private var id = UUID()
    @State private var pricePer100g: Double = 1
    @State private var yarnWeightInProject: Double = 0
    @State private var imagePicker = false
    @State private var currentWeight: Double = 0
    
 
    
    var body: some View {
        NavigationView {
            //VStack {
            Form {
                Section {
                    HStack {
                        Image(uiImage: UIImage(data: yarn.image!)!)
                            .bigCircle
                            .onAppear {
                                image = UIImage(data: yarn.image!)!
                            }
                        //                .sheet(isPresented: $imagePicker) {
                        //                    ImagePickerView(selectedImage: $image)
                        //                }
                        Button {
                            imagePicker.toggle()
                        } label: {
                            Text("Змінити світлину")
                        }.sheet(isPresented: $imagePicker) {
                            ImagePickerView(selectedImage: $image)
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
                            TextField("\(yarn.wrappedName)", text: $name)
                                .onAppear {
                                    name = yarn.wrappedName
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Склад:")
                            TextField("\(yarn.compound!)", text: $compound)
                                .onAppear {
                                    compound = yarn.compound!
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Колір:")
                            TextField("\(yarn.color!)", text: $color)
                                .onAppear {
                                    color = yarn.color!
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
                            TextField("\(yarn.originalWeight)", value: $originalWeight, formatter: NumberFormatter())
                                .onAppear {
                                    originalWeight = yarn.originalWeight
                                }.keyboardType(.numberPad)
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        Text("Поточна вага: \(currentWeight)")
                        HStack {
                            Text("Метрів в 100г:")
                            TextField("\(yarn.footagePer100g)", value: $footagePer100g, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .onAppear {
                                    footagePer100g = yarn.footagePer100g
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Ціна за 100г:")
                            TextField("\(yarn.pricePer100g)", value: $pricePer100g, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .onAppear {
                                    pricePer100g = yarn.pricePer100g
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
                            TextField("\(yarn.shop!)", text: $shop)
                            
                                .onAppear {
                                    shop = yarn.shop!
                                }
                        }
                        .padding(.horizontal, 6)
                        .textFieldStyle(.roundedBorder)
                        DatePicker("Дата:", selection: $date, displayedComponents: [.date])
                            .padding(.horizontal, 6)
                            .onAppear {
                                date = yarn.date!
                            }
                        
                        
                    }
                }
                Section {
                    VStack {
                        Text("Параметри для розрахунків")
                            .bold()
                            .foregroundColor(.indigo)
                        // Text("Поточна вага: \(yarnAndProj.currentYarnWeight)")
                        HStack {
                            HStack {
                                Text("Доставка, грн:")
                                TextField("\(yarn.deliveryPrice)", value: $deliveryPrice, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .onAppear {
                                        deliveryPrice = yarn.deliveryPrice
                                    }
                            }
                            .padding(.horizontal, 6)
                            .textFieldStyle(.roundedBorder)
                            Text("Ціна за 1г, (грн): \(yarn.pricePer1g)")
                                .padding()
                            Text("Загальні витрати: \(yarn.totalExpense) грн")
                                .padding()
                                .bold()
                                .foregroundColor(.purple)
                            //Text("Поточна вага: \(yarnAndProject.currentYarnWeight ?? yarn.originalWeight)")
                        }
                        .padding()
                    }
                }
                Section {
                    VStack {
                        Text("Вироби")
                            .bold()
                            .foregroundColor(.purple)
                            .padding()
                        List {
                            ForEach(yarn.yarnWeightArray) { yarnProj in
                                NavigationLink(destination: ProjectView(project: yarnProj.fromProj!)) {
                                    Image(uiImage: UIImage(data: (yarnProj.fromProj?.image)!) ?? UIImage(imageLiteralResourceName: "sheep"))
                                        .smallCircle
                                        .onAppear {
                                            image = UIImage(data: yarnProj.fromProj!.image!)!
                                        }
                                    Text("\(yarnProj.fromProj?.name ?? "") - \(yarnProj.yarnWeightInProj)г")

                                }
                            }
                        }
                        
                    }
                }
                

                HStack {
                    Spacer()
                    Button("Зберегти") {
                        DataController().editYarn(yarn: yarn, name: name, image: image, compound: compound, footagePer100g: footagePer100g, pricePer100g: pricePer100g, deliveryPrice: deliveryPrice, color: color, shop: shop, date: date, originalWeight: originalWeight, context: moc)
                        dismiss()
                    }
                    .buttonModif
                    Spacer()
                }
            }
            
        }
    }
}


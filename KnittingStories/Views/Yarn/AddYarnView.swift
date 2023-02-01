//
//  AddYarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 11.10.2022.
//
import PhotosUI
import SwiftUI



struct AddYarnView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
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
    @State private var isArchived = false
    
    @State private var imagePicker = false
   
    
    var body: some View {
            Form {
                Section {
                    HStack {
                        Image(uiImage: image)
                            .bigCircle

                        Button(action: {
                            imagePicker.toggle()
                        }, label: {
                            Text("Додати світлину")
                        })
                        .sheet(isPresented: $imagePicker) {
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
                            TextField("Name", text: $name)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Склад:")
                            TextField("Compound", text: $compound)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Колір:")
                            TextField("Color", text: $color)
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
                            TextField("", value: $originalWeight, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            Text("Метрів у 100г:")
                            TextField("Footage per 100g", value: $footagePer100g, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        HStack {
                            Text("Ціна за 100г,(грн):")
                            TextField("Price per 100g", value: $pricePer100g, formatter: NumberFormatter())
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
                            TextField("Shop", text: $shop)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        DatePicker("Дата:", selection: $date, displayedComponents: [.date])
                            .padding()
                        HStack {
                            Text("Доставка, (грн):")
                            TextField("Delivery cost", value: $deliveryPrice, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    }
                }
                Section {
                    Toggle("Перенести пряжу до архиву?", isOn: $isArchived)
                  
                }
                HStack {
                    Spacer()
                    Button("Зберегти") {
                        DataController().addYarn(name: name, image: image, compound: compound, footagePer100g: footagePer100g, pricePer100g: pricePer100g, deliveryPrice: deliveryPrice, color: color, shop: shop, date: date, originalWeight: originalWeight, isArchived: isArchived, context: moc)
                        dismiss()
                    }
                    .buttonModif
                    Spacer()
                }
            }
        }
    }

struct AddYarnView_Previews: PreviewProvider {
    static var previews: some View {
        AddYarnView()
    }
}


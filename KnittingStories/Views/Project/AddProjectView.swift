//
//  AddProjectView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 18.10.2022.
//

import SwiftUI

struct AddProjectView: View {
    
   // @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm: DetailProjectViewModel
    
    init(vm: DetailProjectViewModel) {
        self.vm = vm
    }
    
    @State private var imagePicker = false
    @State private var showTheButton = false
    @State private var showingAlert = false
    @State private var showingYP = false
    @State private var showProjList = false

 //  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Yarn.date, ascending: true)], animation: .default) private var yarns: FetchedResults<Yarn>
   
    
  //  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Project.startDate, ascending: true)], animation: .default) private var projects: FetchedResults<Project>
    
   
  //  @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFavourite == true")) var book: FetchedResults<Book>
  //  @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \YarnProj.fromProj, ascending: true)],
//        predicate: NSPredicate(format: "fromProj == %@", "project")
//    ) var yarnsForPr: FetchedResults<YarnProj>
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(uiImage: vm.image)
                            .smallProjPhoto
                        Button(action: {
                            imagePicker.toggle()
                        }, label: {
                            Text("Додати зображення")
                        })
                        .sheet(isPresented: $imagePicker) {
                            ImagePickerView(selectedImage: $vm.image)
                        }
                    }
                }
                Section {
                    VStack {
                        HStack {
                            Text("Назва:")
                            TextField("Title", text: $vm.name)
                        }.padding()
                        HStack {
                            Text("Загальна вага:")
                            TextField("Total weight", value: $vm.totalWeight, formatter: NumberFormatter())
                        }.padding()
                        HStack {
                            Text("Розмір виробу:")
                            TextField("Size", text: $vm.size)
                        }.padding()
                    }
                }
                Section {
                    VStack {
                        Text("Деталі процесу")
                            .bold()
                            .foregroundColor(.indigo)
                        VStack {
                            DatePicker("Початок:", selection: $vm.startDate, displayedComponents: [.date])
                            DatePicker("Кінець:", selection: $vm.finishDate, displayedComponents: [.date])
                        }.padding()
                        
                        HStack {
                            Text("Розмір спиць:")
                            TextField("Number of needles", text: $vm.needlesNumber)
                        }.padding()
                    }
                    
                }
                Section {
                    Toggle("На продаж", isOn: $vm.forSale).padding()
                    Toggle("Продано", isOn: $vm.sold).padding()
                    if vm.sold {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Маркетплейс:")
                                TextField("Marketplace", text: $vm.marketplace)
                            }.padding()
                            DatePicker("Дата продажу:", selection: $vm.saleDate, displayedComponents: [.date]).padding()
                            HStack {
                                Text("Комісія:")
                                TextField("Comission", value: $vm.comission, formatter: NumberFormatter())
                            }.padding()
                            HStack {
                                Text("Вартість доставки:")
                                TextField("Delivery cost", value: $vm.deliveryCost, formatter: NumberFormatter())
                            }.padding()
                            Text("Загальні витрати: \(vm.additExpenses)")
                                .padding()
                            
                            HStack {
                                Text("Ціна виробу:")
                                TextField("Sale cost", value: $vm.saleCost, formatter: NumberFormatter())
                            }.padding()
                            Text("Прибуток: \(vm.margin)")
                                .padding()
                        }
                    }
                }
                    HStack {
                        Spacer()
                        Button("Зберегти") {
                            vm.addProject(name: vm.name, image: vm.image, totalWeight: vm.totalWeight, startDate: vm.startDate, finishDate: vm.finishDate, forSale: vm.forSale, sold: vm.sold, size: vm.size, needlesNumber: vm.needlesNumber, marketplace: vm.marketplace, saleDate: vm.saleDate, comission: vm.comission, deliveryCost: vm.deliveryCost, saleCost: vm.saleCost)
                            self.dismiss()
                        }
                        .buttonModif
                        Spacer()
                    }
            }
        }
    }
}


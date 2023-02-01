//
//  EditProjectView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 18.10.2022.
//

import SwiftUI

struct EditProjectView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var additExpense: Double = 0
    @State private var comission: Double = 0
    @State private var comments: String = ""
    @State private var deliveryCost: Double = 0
    @State private var finishDate = Date()
    @State private var forSale: Bool = false
    @State private var id = UUID()
    @State private var image = UIImage(imageLiteralResourceName: "llama")
    @State private var marketplace: String = ""
    @State private var name: String = ""
    @State private var needlesNumber: Int16 = 0
    @State private var saleDate = Date()
    @State private var size: String = ""
    @State private var startDate = Date()
    @State private var totalWeight: Double = 0
    @State private var yarnWeight: Double = 0
    @State private var saleCost: Double = 0
    @State private var margin: Double = 0
    @State private var imagePicker = false
    @State private var sold: Bool = false
   // @State public var yarnForProject: [YarnProj]
    
   // @State public var yarnForProjectArray: [YarnProj] = []
   // @State private var array: [YarnProj]
    @State private var showingAlert = false
//    @State private var yarnPicker = false
//
//    @State private var yarn: Yarn?
  //  @State private var yp: YarnProj?
//    @State private var yarnWeightInProj: Double = 0
//    @State private var fromYarn: Yarn?
//    @State private var fromProj: Project?
    @State private var showYarnList = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Yarn.date, ascending: true)], animation: .default) private var yarns: FetchedResults<Yarn>
   public var project: FetchedResults<Project>.Element
    

    
    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {
                        Image(uiImage: UIImage(data: project.image!)!)
                            .bigCircle
                            .onAppear {
                                image = UIImage(data: project.image!)!
                            }
                        
                        Button {
                            imagePicker.toggle()
                        } label: {
                            Text("Змінити світлину")
                        }
                        .sheet(isPresented: $imagePicker) {
                            ImagePickerView(selectedImage: $image)
                        }
                    }
                    HStack {
                        Text("Назва:")
                        TextField("\(project.wrappedName)", text: $name)
                            .onAppear {
                                name = project.wrappedName
                            }
                    }
                    .padding(.horizontal, 6)
                    .textFieldStyle(.roundedBorder)
                    HStack {
                        Text("Загальна вага")
                        TextField("\(project.totalWeight)", value: $totalWeight, formatter: NumberFormatter())
                            .onAppear {
                                totalWeight = project.totalWeight
                            }
                    }
                    HStack {
                        Text("Розмір виробу:")
                        TextField(project.size!, text: $size)
                            .onAppear {
                                size = project.size ?? ""
                            }
                    }
                }
            }
            Section {
                Text("Пряжа")
                    .bold()
                    .foregroundColor(.mint)
                AddYarnProjView(fromProj: project)
               
           }
            
            Section {
                VStack {
                    Text("Деталі процесу")
                    VStack {
                        DatePicker("Початок:", selection: $startDate, displayedComponents: [.date])
                        DatePicker("Кінець:", selection: $finishDate, displayedComponents: [.date])
                    }.padding()
                    
                    HStack {
                        Text("Розмір спиць:")
                        TextField("Number of needles", value: $needlesNumber, formatter: NumberFormatter())
                    }.padding()
                }
                
            }
          Section {
                Toggle("На продаж", isOn: $forSale)
                  .onAppear {
                      forSale = project.forSale
                  }
                Toggle("Продано", isOn: $sold)
                  .onAppear {
                      sold = project.sold
                  }
                
            }
            if sold {
                Section {
                    VStack {
                        HStack {
                            Text("Маркетплейс:")
                            TextField("Marketplace", text: $marketplace)
                        }
                        HStack {
                            Text("Комісія:")
                            TextField("Comission", value: $comission, formatter: NumberFormatter())
                        }
                        Text("Собівартість виробу: \(project.cost)")
                        DatePicker("Дата продажу:", selection: $saleDate, displayedComponents: [.date])
                        HStack {
                            Text("Вартість доставки:")
                            TextField("Delivery cost", value: $deliveryCost, formatter: NumberFormatter())
                        }
                        Text("Загальні витрати: \(additExpense)")
                        HStack {
                            Text("Ціна виробу:")
                            TextField("Sale cost", value: $saleCost, formatter: NumberFormatter())
                        }
                        Text("Прибуток: \(margin)")
                    }
                }
            }
        }
        
        Section {
            HStack {
                Spacer()
                Button {
                    DataController().editProject(project: project, name: name, image: image, totalWeight: totalWeight, startDate: startDate, finishDate: finishDate, forSale: forSale, sold: sold, size: size, needlesNumber: needlesNumber, marketplace: marketplace, saleDate: saleDate, comission: comission, deliveryCost: deliveryCost, saleCost: saleCost, context: moc)
                    dismiss()
                } label: {
                    Text("Зберегти")
                }
                .buttonModif
                Spacer()
            }
        }
    }
    
}


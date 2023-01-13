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
    @State private var yarnProjArray: [YarnProj] = []
    
    
    
    @State private var showingAlert = false
    @State private var yarnPicker = false
    
    @State private var yarn = Yarn()
    @State private var yarnProj = YarnProj()
    @State private var yarnWeightInProject: Double = 0
    
    @State private var showYarnList = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Yarn.date, ascending: true)], animation: .default) private var yarns: FetchedResults<Yarn>
    var project: FetchedResults<Project>.Element
    
    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {
                        Image(uiImage: UIImage(data: project.image!)!)
                            .resizable()
                            .scaledToFit()
                            .edgesIgnoringSafeArea(.all)
                            .clipShape(Circle())
                            .frame(width: 90, height: 90)
                            .shadow(radius: 10)
                            .overlay(Circle()
                                .stroke(Color.gray, lineWidth: 2))
                            .padding(15)
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
                        TextField("\(project.name!)", text: $name)
                            .onAppear {
                                name = project.name ?? ""
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
                List {
                    VStack {
                        ForEach(yarnProjArray) { yarnProj in
                            NavigationLink(destination: YarnView(yarn: yarnProj.fromYarn!)) {
                                HStack {
                                    Image(uiImage: UIImage(data: yarnProj.fromYarn!.image!)!)
                                        .resizable()
                                        .scaledToFit()
                                        .edgesIgnoringSafeArea(.all)
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60)
                                        .shadow(radius: 10)
                                    Text("\(yarnProj.fromYarn!.name!) - \(yarnProj.yarnWeightInProj)г")
                                }
                            }
                        }
                    }
                    Button("Обрати пряжу") {
                        showYarnList.toggle()
                    }
                }.sheet(isPresented: $showYarnList) {
                    List {
                        ForEach(yarns) { yarn in
                            HStack {
                                Image(uiImage: UIImage(data: yarn.image!)!)
                                    .resizable()
                                    .scaledToFit()
                                    .edgesIgnoringSafeArea(.all)
                                    .clipShape(Circle())
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 10)
                                Text(yarn.name ?? "")
                                Spacer()
                                Text(" - \(yarn.originalWeight) г")
                            }
                            .onTapGesture {
                                showingAlert.toggle()
                                yarnProj = YarnProj(context: moc)
                                yarnProj.fromYarn = yarn
                            }
                            .alert("Кількість пряжі", isPresented: $showingAlert) {
                                
                                TextField("", value: $yarnWeightInProject, formatter: NumberFormatter())
                                Button("Ok") {
                                    
                                    
                                    yarnProj.yarnWeightInProj = yarnWeightInProject
                                    yarnProj.fromProj = project
                                    yarnProj.id = UUID()
                                    
                                   // DataController().addYarnProjTest(yarnProj: yarnProj, context: moc)
                                    yarnProjArray.append(yarnProj)

                                    dismiss()
                                }
                            }
                        }
                    }
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
                    // Text("Собівартість виробу: \(yarnProj.cost)")
                }
                
                
                Section {
                    Toggle("На продаж", isOn: $forSale)
                    Toggle("Продано", isOn: $sold)
                    
                }
                if sold {
                    Section {
                        VStack {
                            HStack {
                                Text("Маркетплейс:")
                                TextField("Marketplace", text: $marketplace)
                                
                            }
                            DatePicker("Дата продажу:", selection: $saleDate, displayedComponents: [.date])
                            
                            HStack {
                                Text("Комісія:")
                                TextField("Comission", value: $comission, formatter: NumberFormatter())
                                
                            }
                            HStack {
                                Text("Вартість доставки:")
                                TextField("Delivery cost", value: $deliveryCost, formatter: NumberFormatter())
                                
                            }
                            Text("Загальні витрати: \(additExpense)")
                            HStack {
                                Text("Вартість виробу:")
                                TextField("Sale cost", value: $saleCost, formatter: NumberFormatter())
                            }
                            Text("Прибуток: \(margin)")
                        }
                    }
                }
            }
            
            
            HStack {
                Spacer()
                Button {
                    DataController().editProject(project: project, name: name, image: image, totalWeight: totalWeight, startDate: startDate, finishDate: finishDate, forSale: forSale, sold: sold, size: size, needlesNumber: needlesNumber, marketplace: marketplace, saleDate: saleDate, comission: comission, deliveryCost: deliveryCost, saleCost: saleCost, yarnProjArray: yarnProjArray, context: moc)
                    dismiss()
                } label: {
                    Text("Зберегти")
                }
                
                Spacer()
            }
        }
    }
}
    


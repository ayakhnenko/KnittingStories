//
//  AddProjectView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 18.10.2022.
//

import SwiftUI

struct AddProjectView: View {
    
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
    @State private var saleCost: Double = 0
    @State private var margin: Double = 0
    @State private var sold: Bool = false
    @State private var showYarnList = false
    @State private var imagePicker = false
    
    
    @State private var showTheButton = false
    @State private var showingAlert = false
    @State private var showingYP = false
    @State private var showProjList = false
    //    @State private var yarnPicker = false
    @State private var yarnsProjArray = [YarnProj]()
    // @State private var yarn = Yarn()
    @State private var yarnProj = YarnProj()
    @State private var yarnWeightInProj: Double = 0
    @State private var project = Project()
    @State private var fromProj = Project()
    @State private var fromYarn = Yarn()
    
   @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Yarn.date, ascending: true)], animation: .default) private var yarns: FetchedResults<Yarn>
   
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Project.startDate, ascending: true)], animation: .default) private var projects: FetchedResults<Project>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \YarnProj.fromProj, ascending: true)], animation: .default) private var yarnsForProject: FetchedResults<YarnProj>
  //  @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFavourite == true")) var book: FetchedResults<Book>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \YarnProj.fromProj, ascending: true)],
        predicate: NSPredicate(format: "fromProj == %@", "project")
    ) var yarnsForPr: FetchedResults<YarnProj>
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .edgesIgnoringSafeArea(.all)
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .shadow(radius: 10)
                            .overlay(Circle()
                                .stroke(Color.gray, lineWidth: 2))
                            .padding(15)
                        Button(action: {
                            imagePicker.toggle()
                        }, label: {
                            Text("Додати зображення")
                        })
                        .sheet(isPresented: $imagePicker) {
                            ImagePickerView(selectedImage: $image)
                        }
                    }
                }
                Section {
                    VStack {
                        HStack {
                            Text("Назва:")
                            TextField("Title", text: $name)
                        }.padding()
                        HStack {
                            Text("Загальна вага:")
                            TextField("Total weight", value: $totalWeight, formatter: NumberFormatter())
                        }.padding()
                        HStack {
                            Text("Розмір виробу:")
                            TextField("Size", text: $size)
                        }.padding()
                    }
                }
                Section {
                    VStack {
                        Text("Деталі процесу")
                            .bold()
                            .foregroundColor(.indigo)
                        VStack {
                            DatePicker("Початок:", selection: $startDate, displayedComponents: [.date])
                            DatePicker("Кінець:", selection: $finishDate, displayedComponents: [.date])
                        }.padding()
                        
                        HStack {
                            Text("Розмір спиць:")
                            TextField("Number of needles", value: $needlesNumber, formatter: NumberFormatter())
                        }.padding()
                    }
                    // Text("Собівартість виробу: \(yarnAndProj.cost)")
                }
                Section {
                    Toggle("На продаж", isOn: $forSale).padding()
                    Toggle("Продано", isOn: $sold).padding()
                    if sold {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Маркетплейс:")
                                TextField("Marketplace", text: $marketplace)
                            }.padding()
                            DatePicker("Дата продажу:", selection: $saleDate, displayedComponents: [.date]).padding()
                            HStack {
                                Text("Комісія:")
                                TextField("Comission", value: $comission, formatter: NumberFormatter())
                            }.padding()
                            HStack {
                                Text("Вартість доставки:")
                                TextField("Delivery cost", value: $deliveryCost, formatter: NumberFormatter())
                            }.padding()
                            Text("Загальні витрати: \(additExpense)")
                                .padding()
                            HStack {
                                Text("Вартість виробу:")
                                TextField("Sale cost", value: $saleCost, formatter: NumberFormatter())
                            }.padding()
                            Text("Прибуток: \(margin)")
                                .padding()
                        }
                    }
                }
                
                Section {
                    Text("Пряжа")
                        .bold()
                        .foregroundColor(.mint)
                    List {
                        ForEach(yarnsForProject) { yarnProj in
                            NavigationLink(destination: YarnView(yarn: yarnProj.fromYarn!)) {
                                HStack {
                                    Image(uiImage: UIImage(data: (yarnProj.fromYarn!.image)!) ?? UIImage(imageLiteralResourceName: "llama"))
                                        .resizable()
                                        .scaledToFit()
                                        .edgesIgnoringSafeArea(.all)
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60)
                                        .shadow(radius: 10)
                                    Text("\(yarnProj.fromYarn!.name ?? "") - \(yarnProj.yarnWeightInProj)г")
                                }
                            }
                        }
                    }
                    Button("Додати пряжу в проект") {
                        showYarnList.toggle()
                      
                        //yarnForProject.append(yarnProj)
                       
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
                                }.onTapGesture {
                                    fromYarn = yarn
                                    showingAlert.toggle()
                                }.alert("Кількість пряжі", isPresented: $showingAlert) {
                                    
                                    TextField("", value: $yarnWeightInProj, formatter: NumberFormatter())
                                    
                                    Button("Ok") {
                                        DataController().addYarnProj(fromYarn: fromYarn, yarnWeightInProj: yarnWeightInProj, context: moc)
//                                        let yarnProj = YarnProj(context: moc)
//                                        yarnProj.id = UUID()
//                                        yarnProj.fromYarn = fromYarn
//                                        yarnProj.yarnWeightInProj = yarnWeightInProj
                                        self.yarnsProjArray.append(yarnProj)
                                        
                                        dismiss()
                                   }
                                }
                                
                            }
                        }
                    }
                    HStack {
                        Spacer()
                        Button("Зберегти") {
                            DataController().addProject(name: name, image: image, totalWeight: totalWeight, startDate: startDate, finishDate: finishDate, forSale: forSale, sold: sold, size: size, needlesNumber: needlesNumber, marketplace: marketplace, saleDate: saleDate, comission: comission, deliveryCost: deliveryCost, saleCost: saleCost, yarnsProjArray: yarnsProjArray, context: moc)
                          
                            dismiss()
                            
                        }
                        Spacer()
                    }
          
                }
            }
        }
    }
}


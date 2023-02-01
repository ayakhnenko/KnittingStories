//
//  ProjectView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 14.11.2022.
//

import SwiftUI

 struct ProjectView: View {
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
    @State public var yarnForProject = [YarnProj]()
    @State private var showEditProject = false
    @State private var yarnWeightInProject: Double = 0
    @State private var yarnProj: YarnProj?
    
var project: FetchedResults<Project>.Element
     
//     @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \YarnProj.fromProj , ascending: true)], animation: .default) private var yarnsForProject: FetchedResults<YarnProj>
     
   

    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Image(uiImage: UIImage(data: project.image!)!)
                            .bigCircle
                            .onAppear {
                                image = UIImage(data: project.image!)!
                            }
                    }
                }
                Section {
                    Text("Загальні параметри")
                        .bold()
                        .foregroundColor(.blue)
                    Text("Назва: \(project.wrappedName)")
                    Text("Загальна вага,(г): \(project.totalWeight)")
                    DatePicker("Початок:", selection: $startDate, displayedComponents: [.date])
                        .padding(.horizontal, 6)
                        .onAppear {
                            startDate = project.startDate ?? Date()
                        }
                    DatePicker("Кінець:", selection: $finishDate, displayedComponents: [.date])
                        .padding(.horizontal, 6)
                        .onAppear {
                            finishDate = project.finishDate ?? Date()
                        }
                    Text("Розмір виробу: \(project.size ?? "")")
                    Text("Розмір спиць: \(project.needlesNumber)")
                    
                }
                Section {
                    Text("Пряжа")
                        .bold()
                        .foregroundColor(.blue)
                    List {
                        VStack {
                            ForEach(project.yarnForProjectArray) { yarnProj in
                                NavigationLink(destination: YarnView(yarn: yarnProj.fromYarn!)) {
                                    HStack {
                                        Image(uiImage: UIImage(data: yarnProj.fromYarn!.image!)!)
                                            .smallCircle
                                            .onAppear {
                                                image = UIImage(data: yarnProj.fromYarn!.image!)!
                                            }
                                        Text("\(yarnProj.fromYarn?.name ?? "") -\(yarnProj.yarnWeightInProj) г")
                                            .onAppear {
                                                name = yarnProj.fromYarn?.name ?? ""
                                                yarnWeightInProject = yarnWeightInProject
                                            }
                                    }
                                }
                                //                            }.onAppear {
                                //                                yarnForProject = project.yarnForProjectArray
                            }
                        }
                    }
                }
                if project.forSale {
                    Text("На продаж")
                }
                if project.sold {
                    Section {
                        Text("Параметри для продажу")
                            .bold()
                            .foregroundColor(.blue)
                        Text("Маркетплейс: \(project.marketplace ?? "")")
                        Text("Комісія,(грн): \(project.comission)")
                        DatePicker("Дата продажу:", selection: $saleDate, displayedComponents: [.date])
                            .padding(.horizontal, 6)
                            .onAppear {
                                saleDate = project.saleDate ?? Date()
                            }
                        Text("Собівартість виробу,(грн): \(project.cost)")
                        Text("Вартість доставки,(грн): \(project.deliveryCost)")
                        Text("Загальні витрати,(грн): \(project.additExpense)")
                        Text("Прибуток,(грн): \(project.margin)")
                        
                    }
                }
                
            }
        }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showEditProject.toggle()
                    } label: {
                        Text("Edit")
                    }
                }
            }.sheet(isPresented: $showEditProject) {
                EditProjectView(project: project)
            }
        }
    }


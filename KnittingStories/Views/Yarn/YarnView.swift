//
//  YarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 13.11.2022.
//

import SwiftUI


struct YarnView: View {
    
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

    @State private var showEditYarn = false
   
    @State private var yarnProj = YarnProj()
    @State private var yarnWeightInProject: Double = 0
  //  @State private var yarnProjArray: [YarnProj] = []
    @State private var yarnWeightArray: [YarnProj] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Image(uiImage: UIImage(data: yarn.image!)!)
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
                                image = UIImage(data: yarn.image!)!
                            }
                    }
                }
                Section {
                    Text("Загальні параметри")
                        .bold()
                        .foregroundColor(.purple)
                        .padding()
                    Text("Назва: \(yarn.name ?? "")")
                    Text("Склад: \(yarn.compound ?? "")")
                    Text("Колір: \(yarn.color ?? "")")
                }
                Section {
                    VStack {
                        Text("Вимірювальні параметри")
                            .bold()
                            .foregroundColor(.purple)
                            .padding()
                        Text("Початкова вага: \(yarn.originalWeight)")
                        Text("Метрів у 100г: \(yarn.footagePer100g)")
                        Text("Поточная вага: \(yarn.currentWeight)")
                    }
                }
                Section {
                    VStack(alignment: .leading) {
                        Text("Деталі придбання")
                            .bold()
                            .foregroundColor(.purple)
                            .padding()
                        Text("Крамниця: \(yarn.shop ?? "")")
                        DatePicker("Дата:", selection: $date, displayedComponents: [.date])
                            .padding(.horizontal, 6)
                            .onAppear {
                                date = yarn.date!
                            }
                    }
                }
                Section {
                    Text("Параметри для розрахунків")
                        .bold()
                        .foregroundColor(.purple)
                        .padding()
                    Text("Доставка, грн: \(yarn.deliveryPrice)")
                        .padding()
                    Text("Ціна за 100г: \(yarn.pricePer100g)")
                        .padding()
                    Text("Загальні витрати: \(yarn.totalExpense) грн")
                        .padding()
                    Text("Ціна за 1г, (грн): \(yarn.pricePer1g)")
                        .padding()
                    
                }
                Section {
                    VStack {
                        Text("Вироби")
                            .bold()
                            .foregroundColor(.purple)
                            .padding()
                        List {
                            ForEach(yarnWeightArray) { yarnProj in
                                NavigationLink(destination: ProjectView(project: yarnProj.fromProj!)) {
                                    Image(uiImage: UIImage(data: (yarnProj.fromProj?.image)!) ?? UIImage(imageLiteralResourceName: "sheep"))
                                        .resizable()
                                        .scaledToFit()
                                        .edgesIgnoringSafeArea(.all)
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60)
                                        .shadow(radius: 10)
                                        .padding(15)
                                        .onAppear {
                                            image = UIImage(data: yarnProj.fromProj!.image!)!
                                        }
                                    Text("\(yarnProj.fromProj?.name ?? "") - \(yarnProj.yarnWeightInProj)г")
//                                        .onAppear {
//                                            name = yarnProj.fromProj?.name ?? ""
//                                            yarnWeightInProject = yarnProj.yarnWeightInProject
//                                        }
                                }
                            }.onAppear {
                              //  yarnWeightArray = yarn.yarnWeightArray
                            }
                        }
                        
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showEditYarn.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }.sheet(isPresented: $showEditYarn) {
            EditYarnView(yarn: yarn)
        }
    }
}



//
//  YarnView.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 13.11.2022.
//

import SwiftUI


struct YarnView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    private let storage = NavigationStorage.shared
    @State private var showingEditYarn = false
    @ObservedObject var vm: DetailYarnViewModel
    
    init(vm: DetailYarnViewModel) {
        self.vm = vm
    }
    
  
    var body: some View {
            Form {
                HStack {
                    Spacer()
                    Image(uiImage: vm.yarn!.image)
                        .bigCircle
                        .onAppear {
                            vm.image = vm.yarn!.image
                            vm.dismiss()
                        }
                    Spacer()
                }
                Section {
                    Text("Загальні параметри")
                        .bold()
                        .foregroundColor(.purple)
                        .padding()
                    Text("Назва: \(vm.yarn!.yarn.wrappedName)")
                    Text("Склад: \(vm.yarn!.compound)")
                    Text("Колір: \(vm.yarn!.color)")
                }
                Section {
                    Text("Вимірювальні параметри")
                        .bold()
                        .foregroundColor(.purple)
                        .padding()
                    Text("Початкова вага,(г) : \(vm.yarn!.originalWeight.roundToPlaces())")
                    Text("Метрів у 100г: \(vm.yarn!.footagePer100g.roundToPlaces())")
                    Text("Поточная вага,(г): \(vm.yarn!.yarn.calcCurrentWeight().roundToPlaces())")
                }
                Section {
                        Text("Деталі придбання")
                            .bold()
                            .foregroundColor(.purple)
                            .padding()
                        Text("Крамниця: \(vm.yarn!.shop)")
                        
                    Text("Дата: \(vm.yarn!.date.dateFormatter())")
//                            .onAppear {
//                                yarnVM.date = yarnVM.yarn!.date
//                            }
                }
                Section {
                    Text("Параметри для розрахунків")
                        .bold()
                        .foregroundColor(.purple)
                        .padding()
                    Text("Доставка, (грн): \(vm.yarn!.deliveryPrice.roundToPlaces())")
                    Text("Ціна за 100г: \(vm.yarn!.pricePer100g.roundToPlaces())")
                    Text("Загальні витрати, (грн) : \(vm.yarn!.yarn.totalExpense.roundToPlaces())")
                    Text("Ціна за 1г, (грн): \(vm.yarn!.yarn.pricePer1g.roundToPlaces())")
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
                                    Text("\(yarnProj.yarnWeightInProj.roundToPlaces()) г")
                                }
                                
                            }
                        }
                    }
            
                }
          
            }
 
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingEditYarn.toggle()

                    } label: {
                        Text("Edit")
                    }
                    }
            }.sheet(isPresented: $showingEditYarn) {
                EditYarnView(vm: self.vm)
                                
            }
        }
    }
    
    




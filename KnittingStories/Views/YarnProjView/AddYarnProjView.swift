////
////  SwiftUIView.swift
////  KnittingStories
////
////  Created by Alisa Yakhnenko on 12.12.2022.
////
//
import SwiftUI

struct AddYarnProjView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Yarn.date, ascending: true)], predicate: NSPredicate(format: "isArchived == false")) private var yarns: FetchedResults<Yarn>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Project.finishDate, ascending: true)]) var projects: FetchedResults<Project>
   
    @State public var fromYarn: Yarn?
    @State public var fromProj: Project
    @State public var yarnWeightInProj: Double = 0
    @State private var id = UUID()

    
    @State private var showingAlert = false
    @State private var showingYarnList = false
    @State private var showingProjectList = false
    @State public var array = [YarnProj]()
 
    @State public var project: Project?
   
  
   
    var body: some View {
        List {
            ForEach(array, id: \.self) { yp in
                NavigationLink(destination: YarnView(yarn: yp.fromYarn!)) {
                    HStack {
                        Image(uiImage: UIImage(data: (yp.fromYarn!.image)!) ?? UIImage(imageLiteralResourceName: "llama"))
                            .smallCircle
                        Text("\(yp.fromYarn!.wrappedName) - \(yp.yarnWeightInProj)г")
                    }
                }
            }

            Button("Обрати пряжу") {
              
                showingYarnList.toggle()
            }.sheet(isPresented: $showingYarnList) {
                List {
                    ForEach(yarns) { yarn in
                        HStack {
                            Image(uiImage: UIImage(data: yarn.image!)!)
                                .smallCircle
                            Text(yarn.wrappedName)
                            Spacer()
                            Text(" - \(yarn.originalWeight) г")
                        }.onTapGesture {
                            fromYarn = yarn
                            
                            showingAlert.toggle()
                        }.alert("Кількість пряжі", isPresented: $showingAlert) {
                            
                            TextField("", value: $yarnWeightInProj, formatter: NumberFormatter())
                            
                            Button("Ok") {
                             
                                let yp = DataController().addYarnProj(fromYarn: fromYarn!, fromProj: fromProj, yarnWeightInProj: yarnWeightInProj, context: moc)
                                array.append(yp)
                               
                                
                                dismiss()
                            }
                        }
                    }
                }
            }
    
        }
    }
}

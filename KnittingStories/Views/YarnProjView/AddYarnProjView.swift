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
    
   
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Yarn.date, ascending: true)], animation: .default) private var yarns: FetchedResults<Yarn>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Project.finishDate, ascending: true)]) var projects: FetchedResults<Project>
   
    @State private var fromYarn: Yarn?
    @State private var fromProj: Project?
    @State private var yarnWeightInProj: Double = 0
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
                            .resizable()
                            .scaledToFit()
                            .edgesIgnoringSafeArea(.all)
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .shadow(radius: 10)
                        Text("\(yp.fromYarn!.wrappedName) - \(yp.yarnWeightInProj)г")
                    }
                }
            }
//            Button("Обрати проект") {
//                showingProjectList.toggle()
//            }.sheet(isPresented: $showingProjectList) {
//                List {
//                    ForEach(projects) { project in
//                        HStack {
//                            Image(uiImage: UIImage(data: project.image!) ?? UIImage(imageLiteralResourceName: "llama"))
//                                .smallCircle
//                            Text("\(project.wrappedName)")
//                        }.onTapGesture {
//                            fromProj = project
//
//                            dismiss()
//                        }
//                    }
//                }
//            }
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
                            fromProj = Project(context: moc)
                            showingAlert.toggle()
                        }.alert("Кількість пряжі", isPresented: $showingAlert) {
                            
                            TextField("", value: $yarnWeightInProj, formatter: NumberFormatter())
                            
                            Button("Ok") {
                             
                               let yp = DataController().addYarnProj(fromYarn: fromYarn!, fromProj: fromProj!, yarnWeightInProj: yarnWeightInProj, context: moc)
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

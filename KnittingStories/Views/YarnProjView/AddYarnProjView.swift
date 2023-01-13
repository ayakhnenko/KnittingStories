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
//
//    @State private var showYarnList = false
//    @State private var showProjList = false
//
    var body: some View {
        Text("")
    }
//        Form {
//            Section {
//                Text("Пряжа")
//                    .bold()
//                    .foregroundColor(.mint)
//                List {
//                    ForEach(fromYarn) { yarn in
//                        NavigationLink(destination: YarnView(yarn: yarn)) {
//                            HStack {
//                                Image(uiImage: UIImage(data: yarn.image!)!)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .edgesIgnoringSafeArea(.all)
//                                    .clipShape(Circle())
//                                    .frame(width: 60, height: 60)
//                                    .shadow(radius: 10)
//                                Text("\(yarn.name!)")
//                            }
//                        }
//                    }
//                }
//                TextField("Кількість пряжі", value: $yarnWeightInProj, formatter: NumberFormatter())
//
//                Button("Обрати пряжу") {
//                    showYarnList.toggle()
//                }
//            }.sheet(isPresented: $showYarnList) {
//                List {
//                    ForEach(yarns) { yarn in
//                        HStack {
//                            Image(uiImage: UIImage(data: yarn.image!)!)
//                                .resizable()
//                                .scaledToFit()
//                                .edgesIgnoringSafeArea(.all)
//                                .clipShape(Circle())
//                                .frame(width: 60, height: 60)
//                                .shadow(radius: 10)
//                            Text(yarn.name ?? "")
//                            Spacer()
//                            Text(" - \(yarn.originalWeight) г")
//                        }.onTapGesture {
//                            fromYarn = yarn
//                        }
//                    }
//
//                }
//            }
//            Section {
//                Text("Проект")
//                    .bold()
//                    .foregroundColor(.mint)
//                NavigationLink(destination: ProjectView(project: fromProj)) {
//                    HStack {
//                        Image(uiImage: UIImage(data: fromProj.image!)!)
//                            .resizable()
//                            .scaledToFit()
//                            .edgesIgnoringSafeArea(.all)
//                            .clipShape(Circle())
//                            .frame(width: 90, height: 90)
//                            .shadow(radius: 10)
//                            .overlay(Circle()
//                                .stroke(Color.gray, lineWidth: 2))
//                            .padding(15)
//                        Text(fromProj.name ?? "")
//                    }
//                }
//                Button("Обрати проект") {
//                    showProjList.toggle()
//                }
//            }.sheet(isPresented: $showProjList) {
//                List {
//                    ForEach(projects) { project in
//                        HStack {
//                            Image(uiImage: UIImage(data: project.image!)!)
//                                .resizable()
//                                .scaledToFit()
//                                .edgesIgnoringSafeArea(.all)
//                                .clipShape(Circle())
//                                .frame(width: 60, height: 60)
//                                .shadow(radius: 10)
//                            Text(project.name ?? "")
//                        }.onTapGesture {
//                            fromProj = project
//                        }
//                    }
//
//                }
//                }
//
//                HStack {
//                    Spacer()
//                    Button("Зберегти") {
//                        DataController().addYarnProj(fromYarn: fromYarn, yarnWeightInProject: yarnWeightInProj, fromProject: fromProj, context: moc)
//
//                    }
//                    Spacer()
//                }
//
//        }
//    }
}
//

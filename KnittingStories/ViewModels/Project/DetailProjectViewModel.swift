//
//  DetailProjectViewModel.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 16.02.2023.
//

import Foundation
import SwiftUI
import CoreData

class DetailProjectViewModel: ObservableObject {
    
    private var storage = NavigationStorage.shared
    private (set) var context: NSManagedObjectContext
    @Published var project: ProjectModel?
   weak var parent: ProjectListViewModel?
    
   init(context: NSManagedObjectContext, parent: ProjectListViewModel) {
        self.context = context
       self.parent = parent
        
       print("DetailProjectViewModel init")
    }
    
    
    convenience init(context: NSManagedObjectContext, parent: ProjectListViewModel, project: ProjectModel) {
        self.init(context: context, parent: parent)
        self.project = project
    }

    @Published var additExpenses: Double = 0
    @Published var comission: Double = 0
    @Published var comments: String = ""
    @Published var deliveryCost: Double = 0
    @Published var finishDate = Date()
    @Published var forSale: Bool = false
    @Published var image = UIImage(imageLiteralResourceName: "llama")
    @Published var marketplace: String = ""
    @Published var name: String = ""
    @Published var needlesNumber: String = ""
    @Published var saleDate = Date()
    @Published var size: String = ""
    @Published var startDate = Date()
    @Published var totalWeight: Double = 0
    @Published var saleCost: Double = 0
    @Published var margin: Double = 0
    @Published var sold: Bool = false
    @Published var showYarnList = false
    @Published var imagePicker = false
    
    
    func addProject(name: String, image: UIImage, totalWeight: Double, startDate: Date, finishDate: Date, forSale: Bool, sold: Bool, size: String, needlesNumber: String, marketplace: String, saleDate: Date, comission: Double, deliveryCost: Double, saleCost: Double) {
        do {
            let project = Project(context: context)
            
            project.name = name
            project.image = image.jpegData(compressionQuality: 0.5)
            project.totalWeight = totalWeight
            project.size = size
            project.startDate = startDate
            project.finishDate = finishDate
            project.marketplace = marketplace
            project.forSale = forSale
            project.sold = sold
            project.needlesNumber = needlesNumber
            project.saleDate = saleDate
            project.comission = comission
            project.deliveryCost = deliveryCost
            project.saleCost = saleCost
            
            try project.save()
           
            print("Project was saved")
        } catch {
            print(error)
        }
  
      }
  
      func editProject(project: Project, name: String, image: UIImage, totalWeight: Double, startDate: Date, finishDate: Date, forSale: Bool, sold: Bool, size: String, needlesNumber: String, marketplace: String, saleDate: Date, comission: Double, deliveryCost: Double, saleCost: Double) {
          do {
              project.name = name
              project.image = image.jpegData(compressionQuality: 0.5)
              project.totalWeight = totalWeight
              project.startDate = startDate
              project.finishDate = finishDate
              project.forSale = forSale
              project.sold = sold
              project.size = size
              project.needlesNumber = needlesNumber
              project.marketplace = marketplace
              project.saleDate = saleDate
              project.comission = comission
              project.deliveryCost = deliveryCost
              project.saleCost = saleCost
              
              try  project.save()
          } catch {
              print(error)
          }
      }
    
    
    func selectModelIntent(project: ProjectModel) {
       yarnProjViewModelSpawn(project: project)
    }
    
    private (set) var yarnProjViewModel: YarnProjViewModel?
    
    func yarnProjViewModelSpawn(project: ProjectModel) {
        yarnProjViewModel = YarnProjViewModel(context: context, fromProj: Project(context: context), parent: self)
        storage.path.append(project)
    }

    deinit {
        print("DetailProjectViewModel deinit")
    }
    
    func dismiss() {
        storage.path.removeLast()
       parent?.detailProjectViewModelDispose()
    }
}

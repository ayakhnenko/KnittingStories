//
//  ProjectListViewModel.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 16.02.2023.
//

import Foundation
import CoreData
import SwiftUI


class ProjectListViewModel: NSObject, ObservableObject {
    
    @Published var projects = [ProjectModel]()
    @Published var onSale = [ProjectModel]()
    @Published var sold = [ProjectModel]()
    public var arrayYears: [String] {
         var years = [String]()
        for project in projects {
            years.append(project.finishDate.dateYear())
            years = Array(Set(years))
            years.sort { $0 > $1 }
        }
        return years
    }
    
   
    private var storage = NavigationStorage.shared
    private var fetchResultsController: NSFetchedResultsController<Project>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: Project.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
            guard let projects = fetchResultsController.fetchedObjects else {
                return
            }
            
            self.projects = projects.map(ProjectModel.init)
        } catch {
            print(error)
        }
        sold = projects.filter({ $0.sold })
        onSale = projects.filter({ $0.forSale })
        
        print("ProjectListViewModel init")
    }
    
    func deleteProject(projectId: NSManagedObjectID) {
        do {
            guard let project = try context.existingObject(with: projectId) as? Project else {
                return
            }
            try project.delete()
        } catch {
            print(error)
        }
    }
    
    func selectModelIntent(project: ProjectModel) {
       detailProjectViewModelSpawn(project: project)
    }
    
    private (set) var detailProjectViewModel: DetailProjectViewModel?
    
    func detailProjectViewModelSpawn(project: ProjectModel) {
        detailProjectViewModel = DetailProjectViewModel(context: context, parent: self, project: project)
        storage.path.append(project)
    }
    
    func detailProjectViewModelDispose() {
        detailProjectViewModel = nil
    }
    
    
    deinit {
        print("ProjectListViewModel deinit")
    }
}

extension ProjectListViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let projects = controller.fetchedObjects as? [Project] else {
            return
            
        }
        self.projects = projects.map(ProjectModel.init)
    }
}

    struct ProjectModel: Identifiable, Hashable {
       
        public var project: Project
        
        init(project: Project) {
            self.project = project
        }
        var id: NSManagedObjectID {
            project.objectID
        }
        var image: UIImage {
            UIImage(data: project.image!)!
        }
        var name: String {
            project.name ?? ""
        }
        var totalWeight: Double {
            project.totalWeight
        }
        var startDate: Date {
            project.startDate ?? Date()
        }
        var finishDate: Date {
            project.finishDate ?? Date()
        }
        var sold: Bool {
            project.sold
        }
        var size: String {
            project.size ?? ""
        }
        var saleDate: Date {
            project.saleDate ?? Date()
        }
        var saleCost: Double {
            project.saleCost
        }
        var needlesNumber: String {
            project.needlesNumber ?? ""
        }
        var marketplace: String {
            project.marketplace ?? ""
        }
        var forSale: Bool {
            project.forSale
        }
        var deliveryCost: Double {
            project.deliveryCost
        }
        var comments: String {
            project.comments ?? ""
        }
        var comission: Double {
            project.comission
        }
        var additExpense: Double {
            project.additExpense
        }
        var margin: Double {
            project.margin
        }
        var cost: Double {
            project.cost
        }
        
    }

//
//  YarnProjViewModel.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 16.02.2023.
//

import Foundation
import CoreData
import SwiftUI


class YarnProjViewModel: NSObject, ObservableObject {
    
    private var fetchResultsController: NSFetchedResultsController<Yarn>
    @Published var yarns = [YarnModel]()
    private (set) var context: NSManagedObjectContext
    private var storage = NavigationStorage.shared
    weak var parent: DetailProjectViewModel?
    
    init(context: NSManagedObjectContext, fromProj: Project, parent: DetailProjectViewModel) {
        self.context = context
        self.fromProj = fromProj
        self.parent = parent
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: Yarn.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
            guard let yarns = fetchResultsController.fetchedObjects else {
                return
            }
            
            self.yarns = yarns.map(YarnModel.init)
        } catch {
            print(error)
        }
        print("YarnProjViewModel init")
    }
    
    public weak var fromYarn: Yarn?
    public unowned var fromProj: Project
    @Published var yarnWeightInProj: Double = 0
    @Published var id = UUID()
    
  
    func addYarnProj(fromYarn: Yarn, fromProj: Project, yarnWeightInProj: Double) {
        
        do {
            let yarnProj = YarnProj(context: context)
            yarnProj.id = UUID()
            yarnProj.fromYarn = fromYarn
            yarnProj.fromProj = fromProj
            yarnProj.yarnWeightInProj = yarnWeightInProj
            
            try yarnProj.save()
            
               print("YarnProj was saved")
        } catch {
            print(error)
        }
        
       }
    
    func selectModelIntent(yarn: YarnModel) {
        yarnListViewModelSpawn(yarn: yarn)
    }

    private (set) var yarnListViewModel: YarnListViewModel?

    func yarnListViewModelSpawn(yarn: YarnModel) {
        yarnListViewModel = YarnListViewModel(context: context)
        storage.path.append(yarn)
    }
    
    
    deinit {
        
        print("YarnProjViewModel deinit")
    }
}


extension YarnProjViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let yarns = controller.fetchedObjects as? [Yarn] else {
            return
            
        }
        self.yarns = yarns.map(YarnModel.init)
    }
}


//struct YarnProjModel: Identifiable, Hashable {
//    public var yarnProj: YarnProj
//
//    init(yarnProj: YarnProj) {
//        self.yarnProj = yarnProj
//    }
//    var id: NSManagedObjectID {
//        yarnProj.objectID
//    }
//    var yarnWeightInProj: Double {
//        yarnProj.yarnWeightInProj
//    }
//    var fromYarn: Yarn {
//        yarnProj.fromYarn!
//    }
//    var fromProj: Project {
//        yarnProj.fromProj!
//    }
//
//}

//
//  YarnListViewModel.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 14.02.2023.
//

import Foundation
import CoreData
import SwiftUI




class YarnListViewModel: NSObject, ObservableObject {
    private var storage = NavigationStorage.shared
    @Published var yarns = [YarnModel]()
    @Published var archivedYarns = [YarnModel]()
    @Published var yarnInStock = [YarnModel]()
   
    private var fetchResultsController: NSFetchedResultsController<Yarn>
    private (set) var context: NSManagedObjectContext
    public var arrayYears: [String] {
         var years = [String]()
        for yarn in yarns {
            years.append(yarn.date.dateYear())
            years = Array(Set(years))
            years.sort { $0 > $1 }
        }
        return years
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
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
         archivedYarns = yarns.filter({ $0.isArchived })
        yarnInStock = yarns.filter({ $0.isArchived == false })
        print("YarnListViewModel init")
    }
    
 
    
    func deleteYarn(yarnId: NSManagedObjectID) {
        do {
            guard let yarn = try context.existingObject(with: yarnId) as? Yarn else {
                return
            }
            try yarn.delete()
        } catch {
            print(error)
        }
    }
    
    func selectModelIntent(yarn: YarnModel) {
       detailYarnViewModelSpawn(yarn: yarn)
    }
   
    
    private (set) var detailYarnViewModel: DetailYarnViewModel?
    
    func detailYarnViewModelSpawn(yarn: YarnModel) {
        detailYarnViewModel = DetailYarnViewModel(context: context, parent: self, yarn: yarn)
        storage.path.append(yarn)
    }
    
    func detailYarnViewModelDispose() {
        detailYarnViewModel = nil
    }
    
    deinit {
        print("YarnListViewModel deinit")
    }
    
    
}

extension YarnListViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let yarns = controller.fetchedObjects as? [Yarn] else {
            return
        }
        self.yarns = yarns.map(YarnModel.init)
   }
}

struct YarnModel: Identifiable, Hashable {
    
    public var yarn: Yarn
    
    init(yarn: Yarn) {
        self.yarn = yarn
    }
    
    var id: NSManagedObjectID {
        yarn.objectID
    }
    
    var name: String {
        yarn.name ?? ""
    }

    var date: Date {
        yarn.date ?? Date()
    }

    var image: UIImage {
        UIImage(data: yarn.image!)!
      
    }

    var originalWeight: Double {
        yarn.originalWeight
    }

    var currentWeight: Double {
        yarn.calcCurrentWeight()
    }
    var color: String {
        yarn.color ?? ""
    }
    var compound: String {
        yarn.compound ?? ""
    }
    var deliveryPrice: Double {
        yarn.deliveryPrice
    }
    var footagePer100g: Double {
        yarn.footagePer100g
    }
    var isArchived: Bool {
        yarn.isArchived
    }
    var pricePer100g: Double {
        yarn.pricePer100g
    }
    var shop: String {
        yarn.shop ?? ""
    }
}

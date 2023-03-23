//
//  DetailYarnViewModel.swift
//  KnittingStories
//
//  Created by Alisa Yakhnenko on 14.02.2023.
//


import SwiftUI
import CoreData

class DetailYarnViewModel: ObservableObject {
    private var storage = NavigationStorage.shared
    private (set) var context: NSManagedObjectContext
    @Published var yarn: YarnModel?
    weak var parent: YarnListViewModel?
   
   
    init(context: NSManagedObjectContext, parent: YarnListViewModel) {
        self.context = context
        self.parent = parent
        
    print("DetailYarnViewModel init")
    }

    convenience init(context: NSManagedObjectContext, parent: YarnListViewModel, yarn: YarnModel) {
        self.init(context: context, parent: parent)
        self.yarn = yarn
       
    }


    @Published var name = ""
    @Published var image = UIImage(imageLiteralResourceName: "sheep")
    @Published var date = Date()
    @Published var compound = ""
    @Published var footagePer100g = 0.0
    @Published var originalWeight = 1.0
    @Published var shop = ""
    @Published var deliveryPrice = 0.0
    @Published var color = ""
    @Published var pricePer100g = 1.0
    @Published var isArchived = false
    @Published var currentWeight = 0.0

    


    func addYarn(name: String, image: UIImage, compound: String, footagePer100g: Double, pricePer100g: Double, deliveryPrice: Double, color: String, shop: String, date: Date, originalWeight: Double, isArchived: Bool) {
        do {
            
            let yarn = Yarn(context: context)
            yarn.name = name
            yarn.image = image.jpegData(compressionQuality: 0.5)
            yarn.compound = compound
            yarn.footagePer100g = footagePer100g
            yarn.pricePer100g = pricePer100g
            yarn.deliveryPrice = deliveryPrice
            yarn.color = color
            yarn.shop = shop
            yarn.date = date
            yarn.originalWeight = originalWeight
            yarn.isArchived = isArchived
            
            try yarn.save()
            print("Data save")
        }
        catch {
            print(error)
        }
        
    }
    
    func editYarn(yarn: Yarn, name: String, image: UIImage, compound: String, footagePer100g: Double, pricePer100g: Double, deliveryPrice: Double, color: String, shop: String, date: Date, originalWeight: Double, isArchived: Bool) {
        do {
            
            yarn.name = name
            yarn.image = image.jpegData(compressionQuality: 0.5)
            yarn.compound = compound
            yarn.footagePer100g = footagePer100g
            yarn.pricePer100g = pricePer100g
            yarn.deliveryPrice = deliveryPrice
            yarn.color = color
            yarn.shop = shop
            yarn.date = date
            yarn.originalWeight = originalWeight
            yarn.isArchived = isArchived

            try yarn.save()
            print(image.size)
        }
        catch {
            print(error)
        }
    }
    
    deinit {
        print("DetailYarnViewModel deinit")
    }
    
    func dismiss() {
        //storage.path.removeLast()
       parent?.detailYarnViewModelDispose()
    }
}

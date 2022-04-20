//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Julian Gierl on 20.04.22.
//

import Foundation
import CoreData

class PortfolioDataService{
  private let container: NSPersistentContainer
  private let containerName = "PortfolioContainer"
  private let entityName = "PortfolioEntity"
  
  @Published var savedEntities = [PortfolioEntity]()
  
  init(){
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error{
        print("error loading core data \(error)")
      }
    }
    self.getPortfolio()
  }
  
  // MARK: Public
  
  func updatePortfolio(coin: CoinModel, amount: Double){
    if let entity = savedEntities.first(where: { $0.coinID == coin.id}){
      if amount > 0{
        update(coin: entity, amount: amount)
      }else{
        remove(entity: entity)
      }
    }else{
      add(coin: coin, amount: amount)
    }
  }
  
  
  // MARK: PRIVATE
  
  private func getPortfolio(){
    let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
    do{
      savedEntities = try container.viewContext.fetch(request)
    }catch{
      print("error fetching portfolio entities \(error)")
    }
  }
  
  private func add(coin: CoinModel, amount: Double){
    let entity = PortfolioEntity(context: container.viewContext)
    entity.coinID = coin.id
    entity.amount = amount
    applyChanges()
  }
  
  private func update(coin: PortfolioEntity, amount: Double){
    coin.amount = amount
    applyChanges()
  }
  
  private func remove(entity: PortfolioEntity){
    container.viewContext.delete(entity)
    applyChanges()
  }
  
  private func save(){
    do{
      try container.viewContext.save()
    }catch{
      print("Erorr saving coredata")
    }
  }
  
  private func applyChanges(){
    save()
    getPortfolio()
  }
}

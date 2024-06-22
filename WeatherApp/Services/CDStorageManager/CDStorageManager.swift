//
//  CDStorageManager.swift
//  WeatherApp
//
//  Created by Arsalan on 21.06.2024.
//

import Foundation
import CoreData

final class CDStorageManager {
    private let queue = DispatchQueue.init(label: "coreDataSyncQueue", qos: .background)
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error { fatalError("Loading container failed") }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init() {
        urlDocumentDirectory()
    }
    
    func urlDocumentDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}

//  MARK: - CRUD
extension CDStorageManager {
    //  MARK: - Create
    func storeCityData(_ data: [CityData], completion: @escaping (Bool) -> Void) {
        queue.sync { [context] in
            data.forEach { cityData in
                let city = CityEntity(context: context)
                city.setCityData(cityData)
            }
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    //  MARK: - Read
    func fetchCityData(with id: Int, completion: @escaping (CityData?) -> Void) {
        queue.sync { [context] in
            let fetchRequest = CityEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
            let fetchResult = try? context.fetch(fetchRequest)
            let city = fetchResult?.first
            
            DispatchQueue.main.async {
                if let city {
                    completion(city.cityData)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func fetchCityData(completion: @escaping ([CityData]?) -> Void) {
        queue.sync {
            let fetchRequest = CityEntity.fetchRequest()
            let fetchResult = try? context.fetch(fetchRequest)
            let data = fetchResult?.map(\.cityData)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    func fetchCityData(with searchQuery: String?, completion: @escaping ([CityData]) -> Void) {
        let fetchRequest = CityEntity.fetchRequest()
        let nameDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let stateDescriptor = NSSortDescriptor(key: "state", ascending: true)
        let countryDescriptor = NSSortDescriptor(key: "country", ascending: true)
        fetchRequest.sortDescriptors = [nameDescriptor, stateDescriptor, countryDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        if let searchQuery {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchQuery.lowercased())
        }
        
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { request in
            if let result = request.finalResult {
                let data = result.map (\.cityData)
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
        
        do {
            try context.execute(asyncFetchRequest)
        } catch {
            DispatchQueue.main.async {
                completion([])
            }
        }
    }
    
    //  MARK: - Update
    func updateCityData(with id: Int, newData: CityData, completion: @escaping (Bool) -> Void) {
        queue.sync { [context] in
            let fetchRequest = CityEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", String(id))
            let fetchResult = try? context.fetch(fetchRequest)
            let city = fetchResult?.first
            
            city?.setCityData(newData)
            
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }
    }
    
    //  MARK: - Delete
    func removeAllCityData(completion: @escaping (Bool) -> Void) {
        queue.sync { [context] in
            let fetchRequest = CityEntity.fetchRequest()
            let fetchResult = try? context.fetch(fetchRequest)
            
            fetchResult?.forEach { city in
                context.delete(city)
            }
            
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func removeCityData(with id: Int, completion: @escaping (Bool) -> Void) {
        queue.sync { [context] in
            let fetchRequest = CityEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
            let fetchResult = try? context.fetch(fetchRequest)
            
            fetchResult?.forEach { city in
                context.delete(city)
            }
            
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
}

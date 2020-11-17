//
//  File.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

protocol IPolicyEventStreamViewModel {
    func fetch(_ completion: @escaping () -> Void)
    func car(at indexPath: IndexPath) -> Car
}

class PolicyEventStreamViewModel: IPolicyEventStreamViewModel {
    private var model: PolicyEventStream
    
    init(_ networkFeature: IPolicyEventStreamNetworkFeature) {
        model = PolicyEventStream(networkFeature)
    }
    
    func fetch(_ completion: @escaping () -> Void) {
        model.fetch(completion)
    }
    
    func car(at indexPath: IndexPath) -> Car {
        return model.cars[indexPath.section][indexPath.row]
    }
}

protocol PolicyEventStreamViewModelDelegate {
    func numberOfSections() -> Int
    func numberOfRows(_ section: Int) -> Int
    func item(at indexPath: IndexPath) -> ICarViewModel
}

extension PolicyEventStreamViewModel: PolicyEventStreamViewModelDelegate {
    func numberOfSections() -> Int {
        return model.cars.count
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return model.cars[section].count
    }
    
    func item(at indexPath: IndexPath) -> ICarViewModel {
        return CarViewModel(model.cars[indexPath.section][indexPath.row])
    }
    
    
}

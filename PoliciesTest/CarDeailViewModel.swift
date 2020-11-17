//
//  PolicyEventViewModel.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

protocol ICarDeailViewModel {
    var make: String { get }
    var vrm: String { get }
    var policyCount: String { get }
    var policyState: PolicyState { get }
    var remaining: Int { get }
}

class CarDetailViewModel: ICarDeailViewModel {
    
    private var car: Car
    
    var make: String {
        return "\(car.vehicle.make) \(car.vehicle.model)"
    }
    
    var vrm: String {
        return car.vehicle.prettyVrm
    }
    
    var policyCount: String {
        return String(car.policies?.count ?? 0)
    }
    
    var policyState: PolicyState {
        return car.hasActivePolicy() ? .extend : .insure
    }
    
    var remaining: Int {
        return car.activePolicyRemainingTime
    }
    
    init(_ car: Car) {
        self.car = car
    }
}

protocol CarDetailViewModelDelegate {
    func numberOfRows(_ section: Int) -> Int
    func item(at indexPath: IndexPath) -> IPolicyViewModel
}

extension CarDetailViewModel: CarDetailViewModelDelegate {
    func numberOfRows(_ section: Int) -> Int {
        return car.policies?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> IPolicyViewModel {
        return PolicyViewModel(car.policies![indexPath.row])
    }
}

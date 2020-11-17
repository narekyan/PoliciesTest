//
//  PolicyEventViewModel.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

enum PolicyState {
    case extend,
         insure
         
}

protocol ICarViewModel {
    var make: String { get }
    var model: String { get }
    var vrm: String { get }
    var policyCount: String { get }
    var policyState: PolicyState { get }
    var remaining: Int { get }
    var notes: String { get }
}

class CarViewModel: ICarViewModel {
    
    private var car: Car
    
    var make: String {
        return car.vehicle.make
    }
    
    var model: String {
        return "\(car.vehicle.color) \(car.vehicle.model)"
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
    
    var notes: String {
        return car.vehicle.notes
    }
    
    init(_ car: Car) {
        self.car = car
    }
}

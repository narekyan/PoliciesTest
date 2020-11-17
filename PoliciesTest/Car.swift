//
//  Car.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

class Car {
    var vehicle: Vehicle
    var policies: [Policy]?
    
    private var _activePolicyRemainingTime: Int?
    var activePolicyRemainingTime: Int {
        if _activePolicyRemainingTime == nil {
            _activePolicyRemainingTime = 0
            let now = Int(Date().timeIntervalSince1970) - 26250000
            if let active = policies?.first(where: {
                return DateUtils.convertDateToSeconds(date: $0.endDate()) > now
            }) {
                _activePolicyRemainingTime = DateUtils.convertDateToSeconds(date: active.endDate()) - now
            }
        }
        return _activePolicyRemainingTime ?? 0
    }
    
    func hasActivePolicy() -> Bool {
        return activePolicyRemainingTime > 0
    }
    
    init(_ vehicle: Vehicle, policies: [Policy]) {
        self.vehicle = vehicle
        self.policies = policies
    }
}

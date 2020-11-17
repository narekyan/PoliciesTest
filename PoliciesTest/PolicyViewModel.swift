//
//  PolicyEventViewModel.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

protocol IPolicyViewModel {
    var duration: String { get }
    var startDate: String { get }
    var endDate: String { get }
}

class PolicyViewModel: IPolicyViewModel {
    
    private var policy: Policy
    static private let dateFormatter = DateFormatter()
    
    var duration: String {
        return DateUtils.userFriendlyTime(seconds: policy.duration())
    }
    
    var startDate: String {
        if let date = DateUtils.convertDate(date: policy.startDate()) {
            PolicyViewModel.dateFormatter.dateStyle = .medium
            PolicyViewModel.dateFormatter.timeStyle = .short
            return PolicyViewModel.dateFormatter.string(from: date)
        }
        return " "
    }
    
    var endDate: String {
        if let date = DateUtils.convertDate(date: policy.endDate()) {
            PolicyViewModel.dateFormatter.dateStyle = .medium
            PolicyViewModel.dateFormatter.timeStyle = .short
            return PolicyViewModel.dateFormatter.string(from: date)
        }
        return " "
    }
   
    init(_ policy: Policy) {
        self.policy = policy
    }
}

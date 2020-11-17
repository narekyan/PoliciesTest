//
//  PolicyEventStreamStructs.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

struct PolicyEvent: Decodable {
    var type: PolicyType
    var payload: Payload
}

enum PolicyType: String, Decodable {
    case policyCreated = "policy_created",
         policyExtension = "policy_extension",
         policyCancelled = "policy_cancelled"
}

struct Payload: Decodable {
    var timestamp: String?
    var policyId: String
    var originalPolicyId: String?
    var startDate: String?
    var endDate: String?
    var vehicle: Vehicle?
}

struct Vehicle: Decodable, Comparable, Hashable {
    var prettyVrm: String
    var make: String
    var model: String
    var variant: String?
    var color: String
    var notes: String
    
    static func < (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.prettyVrm == rhs.prettyVrm
    }
}

//
//  File.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

class PolicyEventStream {
    private var networkFeature: IPolicyEventStreamNetworkFeature
    private var events: [PolicyEvent]?
    private var error: String?
    
    var cars = [[Car]]()
    
    init(_ networkFeature: IPolicyEventStreamNetworkFeature) {
        self.networkFeature = networkFeature
    }
    
    func fetch(_ completion: @escaping () -> Void) {
        networkFeature.getStream { (events:[PolicyEvent]?, error: String?) in
            self.error = error
            self.events = events
            self.populateData()
            completion()
        }
    }
    
}

extension PolicyEventStream {
    private func populateData() {
        if let events = events {
            
            let cancelEvents = events.filter({ $0.type == .policyCancelled })
            var updatedEvents = [PolicyEvent]()
            events.filter({ $0.type != .policyCancelled }).forEach { (event) in
                if let cancelled = cancelEvents.first(where: { $0.payload.policyId == event.payload.policyId }) {
                    var event = event
                    event.payload.endDate = cancelled.payload.timestamp
                    updatedEvents.append(event)
                } else {
                    updatedEvents.append(event)
                }
            }
            
            /** Getting vehicles from json data structure **/
            let vehicles = Array(Set(updatedEvents.compactMap({ $0.payload.vehicle })))
            let cars = vehicles.map { (vehicle) -> Car in
                
                /** Create policies for every vehicle **/
                let policies = updatedEvents.filter({ $0.payload.vehicle == vehicle && $0.type == .policyCreated })
                    .map({ Policy($0.payload.policyId, events: [$0]) })
                
                /** updated previously created policies based on policy extension **/
                updatedEvents.filter({ $0.type == .policyExtension }).forEach { (event) in
                    policies.first(where: { $0.id == event.payload.originalPolicyId })?
                        .events.append(event)
                }

                /** for every vehicle I create car object with his related policies **/
                let car = Car(vehicle, policies: policies)
                return car
            }
            
            /** here I devide cars object into cars with active policies and with no active policies **/
            self.cars.insert(cars.filter({ $0.hasActivePolicy() }), at: self.cars.count)
            self.cars.insert(cars.filter({ !$0.hasActivePolicy() }), at: self.cars.count)
        }
    }
}

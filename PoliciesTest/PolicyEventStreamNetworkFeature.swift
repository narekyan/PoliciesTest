//
//  NetworkFeature.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

protocol IPolicyEventStreamNetworkFeature {
    func getStream(completion: @escaping (_ stream: [PolicyEvent]?, _ errorMessage: String?) -> Void)
}

class PolicyEventStreamNetworkFeature: NetworkFeature, IPolicyEventStreamNetworkFeature {
    
    fileprivate static let ApiUrl = "https://cuvva.herokuapp.com/08-10-2020"
    
    func getStream(completion: @escaping ([PolicyEvent]?, String?) -> Void) {
        get(PolicyEventStreamNetworkFeature.ApiUrl, completion: completion)
    }
    
}

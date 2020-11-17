//
//  ViewModelFactory.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

final class ViewModelFactory {
    
    func getPolicyEventStreamViewModel(_ networkFeature: IPolicyEventStreamNetworkFeature) -> IPolicyEventStreamViewModel & PolicyEventStreamViewModelDelegate {
        return PolicyEventStreamViewModel(networkFeature)
    }

    func getCarDetailViewModel(_ model: Car) -> ICarDeailViewModel & CarDetailViewModelDelegate {
        return CarDetailViewModel(model)
    }
}

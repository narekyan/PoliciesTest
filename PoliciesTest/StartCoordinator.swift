//
//  CoordinatorManager.swift
//  fanFone
//
//  Created by Narek on 10/22/20.
//  Copyright © 2020 fanFone. All rights reserved.
//

import UIKit

protocol IStartCoordinator: class {
    func showDetail(_ car: Car)
}

class StartCoordinator {
 
    private var navigationController: UINavigationController?
    private lazy var viewModelFactory: ViewModelFactory = {
       return ViewModelFactory()
    }()
    private lazy var networkLayer: IPolicyEventStreamNetworkFeature = {
       return PolicyEventStreamNetworkFeature()
    }()
    
    func start(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
        startList()
    }
    
    private func startList() {
        let vc = pushViewController(ListViewController.self)
        vc.viewModel = viewModelFactory.getPolicyEventStreamViewModel(networkLayer)
        vc.coordinatorDelegate = self
    }
    
    private func startDetail(_ car: Car) {
        let vc = pushViewController(DetailViewController.self)
        vc.viewModel = viewModelFactory.getCarDetailViewModel(car)
    }
    
    private func pushViewController<T: UIViewController>(_ type: T.Type) -> T {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: type))

        self.navigationController?.pushViewController(vc, animated: true)
        return vc as! T
    }
}

extension StartCoordinator: IStartCoordinator {
    func showDetail(_ car: Car) {
        startDetail(car)
    }
}

//
//  ViewController.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
        
    weak var coordinatorDelegate: IStartCoordinator?
    var viewModel: (IPolicyEventStreamViewModel & PolicyEventStreamViewModelDelegate)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.fetch {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        view.font = UIFont.systemFont(ofSize: 13)
        view.backgroundColor = UIColor(named: "bg_surface")
        switch section {
        case 0:
            view.text = "    Active policies"
        case 1:
            view.text = "    My garage"
        default: break
        }
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CarCell else { fatalError() }
        cell.viewModel = viewModel?.item(at:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let car = viewModel?.car(at: indexPath) {
            coordinatorDelegate?.showDetail(car)
        }
        
//        viewModel?.item(at:indexPath)
    }
}

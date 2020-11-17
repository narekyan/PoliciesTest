//
//  DetailViewController.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var makeLabel: UILabel!
    @IBOutlet var vrmLabel: UILabel!
    @IBOutlet var policyCountLabel: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    @IBOutlet weak var remainingViewheight:NSLayoutConstraint!
    @IBOutlet var policyStateLabel: UILabel!

    var viewModel: (ICarDeailViewModel & CarDetailViewModelDelegate)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeLabel.text = viewModel?.make
        vrmLabel.text = viewModel?.vrm
        policyCountLabel.text = viewModel?.policyCount
        remainingLabel.text = DateUtils.userFriendlyTime(seconds: viewModel?.remaining ?? 0)
        tableView.rowHeight = PolicyCell.cellheight
        
        switch viewModel?.policyState {
        case .extend:
            policyStateLabel.text = "Extend cover"
            policyStateLabel.backgroundColor = UIColor(named: "bg_green")
            policyStateLabel.textColor = UIColor(named: "txt_white")
        case .insure: fallthrough
        case .none:
            policyStateLabel.text = "Insure now"
            policyStateLabel.backgroundColor = UIColor(named: "txt_minor")
            policyStateLabel.textColor = UIColor(named: "txt_normal")
            remainingViewheight.constant = 0
        }
    }
    

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PolicyCell else { fatalError() }
        cell.viewModel = viewModel?.item(at: indexPath)
        return cell
    }
}

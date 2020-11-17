//
//  PolicyEventCell.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet var makeLabel: UILabel!
    @IBOutlet var modelLabel: UILabel!
    @IBOutlet var vrmLabel: UILabel!
    @IBOutlet var policyCountLabel: UILabel!
    @IBOutlet var policyStateLabel: UILabel!
    @IBOutlet var remainingLabel: UILabel!
    @IBOutlet weak var remainingViewheight: NSLayoutConstraint!
    @IBOutlet var notesLabel: UILabel!
    
    var viewModel: ICarViewModel? {
        didSet {
            makeLabel.text = viewModel?.make
            modelLabel.text = viewModel?.model
            vrmLabel.text = viewModel?.vrm
            policyCountLabel.text = viewModel?.policyCount
            remainingLabel.text = DateUtils.userFriendlyTime(seconds: viewModel?.remaining ?? 0) + " remaining"
            notesLabel.text = viewModel?.notes
            
            switch viewModel?.policyState {
            case .extend:
                policyStateLabel.text = "Extend"
                policyStateLabel.backgroundColor = UIColor(named: "bg_green")
                policyStateLabel.textColor = UIColor(named: "txt_white")
            case .insure: fallthrough
            case .none:
                policyStateLabel.text = "Insure"
                policyStateLabel.backgroundColor = UIColor(named: "txt_minor")
                policyStateLabel.textColor = UIColor(named: "txt_normal")
                remainingViewheight.constant = 0
            }
        }
    }
}

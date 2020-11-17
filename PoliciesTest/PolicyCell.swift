//
//  PolicyCell.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import UIKit

class PolicyCell: UITableViewCell {
    
    static let cellheight: CGFloat = 80
    
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var endLabel: UILabel!

    var viewModel: IPolicyViewModel? {
        didSet {
            durationLabel.text = viewModel?.duration
            startLabel.text = viewModel?.startDate
            endLabel.text = viewModel?.endDate
        }
    }
}

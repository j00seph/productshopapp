//
//  FilterCell.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit


class FilterCell: UICollectionViewCell{
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var onTapDelete: (() -> Void)?
    var data: (category: String, isEnabled: Bool)? {
        didSet{
            guard let data = data else { return }
            containerView.backgroundColor = data.isEnabled ? #colorLiteral(red: 1, green: 0.769361794, blue: 0.8742938638, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        onTapDelete?()
    }
    
}

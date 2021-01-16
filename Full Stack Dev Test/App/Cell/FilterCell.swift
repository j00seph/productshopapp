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
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        onTapDelete?()
    }
    
}

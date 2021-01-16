//
//  CartCell.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit


class CartCell: UITableViewCell{
    
    var data: Product?{
        didSet{
            guard let data = data else { return }
            nameLabel.text = data.name
            priceLabel.text = "$\(data.price)"
            containerView.backgroundColor = UIColor.init(hexString: data.bgColor)
        }
    }
    
    var onTapDelete: (()-> Void)?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        onTapDelete?()
    }
    
}

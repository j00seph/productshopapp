//
//  ProductCell.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit

class ProductCell: UITableViewCell{
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIViewDesignable!
    
    var data: Product?{
        didSet{
            guard let data = data else { return }
            productImage.image = UIImage(named: data.id)
            containerView.backgroundColor = UIColor.init(hexString: data.bgColor)
            categoryLabel.text = data.category
            nameLabel.text = data.name
            priceLabel.text = "$\(data.price)"
        }
    }
    
}

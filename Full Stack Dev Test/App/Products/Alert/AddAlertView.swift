//
//  AddAlertView.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit

class AddAlertView: UIView {
    
    class func instanceFromNib() -> AddAlertView {
        return UINib(nibName: "AddAlertView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AddAlertView
    }
    
    func hide() {
        removeFromSuperview()
    }

    @IBAction func didTapClose(_ sender: UIButton) {
        self.hide()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageLabel.text = "\(product) has been added to your cart."
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.hide()
        }
    }
    
    var product = ""
    
    @IBOutlet weak var messageLabel: UILabel!
    
}
    

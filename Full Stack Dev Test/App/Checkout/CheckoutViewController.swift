//
//  CheckoutViewController.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit

class CheckoutViewController: UIViewController{
    
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var cartLabel: UILabel!
    var cart: [Product] = []
    
    @IBOutlet weak var thumbCenter: NSLayoutConstraint!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func didTapPay(_ sender: UIButton) {
        guard nameTextField.text! != "", emailTextField.text! != "" else {
            return
        }
        if !isSwitchEnabled {
            return
        }
        performSegue(withIdentifier: "ShowConfirmationSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        badgeView.isHidden = cart.isEmpty ? true : false
        cartLabel.text = "\(cart.count)"
    }
    
    var isSwitchEnabled = false {
        didSet{
            NSLayoutConstraint.setMultiplier(isSwitchEnabled ? 1.4 : 0.6, of: &thumbCenter)
        }
    }
    
    @IBAction func didTapSwitch(_ sender: UIButton) {
        isSwitchEnabled.toggle()
    }
}

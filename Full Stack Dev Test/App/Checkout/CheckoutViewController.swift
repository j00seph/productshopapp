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
    
    @IBOutlet weak var switchView: UIView!
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
        writeJsonFile()
        performSegue(withIdentifier: "ShowConfirmationSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        badgeView.isHidden = cart.isEmpty ? true : false
        cartLabel.text = "\(cart.count)"
    }
    
    var isSwitchEnabled = false {
        didSet{
            switchView.backgroundColor = isSwitchEnabled ? #colorLiteral(red: 1, green: 0.7275989056, blue: 0, alpha: 1) : #colorLiteral(red: 0.9153900146, green: 0.905616343, blue: 0.9955919385, alpha: 1)
            NSLayoutConstraint.setMultiplier(isSwitchEnabled ? 1.4 : 0.6, of: &thumbCenter)
        }
    }
    
    @IBAction func didTapSwitch(_ sender: UIButton) {
        isSwitchEnabled.toggle()
    }
    
    private func writeJsonFile(){
        if let encodedData = try? JSONEncoder().encode(cart) {
            let path = "/path/to/order_\(UUID().uuidString).json"
            let pathAsURL = URL(fileURLWithPath: path)
            do {
                try encodedData.write(to: pathAsURL)
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
}

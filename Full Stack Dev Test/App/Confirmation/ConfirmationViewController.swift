//
//  ConfirmationViewController.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit


class ConfirmationViewController: UIViewController{
    
    var orderId = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderIdLabel.text = "Your order ID is #\(orderId)"
    }
    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBAction func didTapReturn(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Products", bundle: nil)
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "Products") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = viewController
    }
}

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
        orderIdLabel.text = "#\(orderId)"
    }
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBAction func didTapReturn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: false)
    }
}

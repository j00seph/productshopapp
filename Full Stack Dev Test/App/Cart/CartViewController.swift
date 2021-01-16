//
//  CartViewController.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit


protocol CartViewControllerDelegate: class{
    func didTapBack(_ cart: [Product])
}

class CartViewController: UIViewController{
    
    weak var delegate: CartViewControllerDelegate?
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var cartLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        }
    }
    
    var cart: [Product] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        badgeView.isHidden = cart.isEmpty ? true : false
        cartLabel.text = "\(cart.count)"
    }
    
    @IBAction func didTapCart(_ sender: UIButton) {
        delegate?.didTapBack(cart)
        self.navigationController?.popViewController(animated: false)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.data = cart[indexPath.row]
        cell.onTapDelete = { [weak self] in
            self?.cart.remove(at: indexPath.row)
            self?.cartLabel.text = "\(self?.cart.count ?? 1)"
            self?.badgeView.isHidden = (self?.cart.count ?? 0) == 0 ? true : false
            self?.tableView.reloadData()
        }
        return cell
    }
    
    
}

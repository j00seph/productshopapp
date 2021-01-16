//
//  ViewController.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var cartLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productList = loadProducts()
        filterList = loadFilters()
        selectedProducts = []
    }

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        }
    }
    
    @IBAction func didTapCart(_ sender: UIButton) {
        if selectedProducts.isEmpty { return }
        performSegue(withIdentifier: "ShowCartSegue", sender: nil)
    }
    
    var filterList: [(category: String, isEnabled: Bool)] = []{
        didSet{
            setupFilteredProduct()
            collectionView.reloadData()
            filterList[0].isEnabled = filterList.filter({ $0.category != "All" && $0.isEnabled }).isEmpty
        }
    }
    
    var productList: [Product] = []
        
    var filteredProductList: [Product] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    var selectedProducts: [Product] = []{
        didSet{
            selectedProducts = Array(Set(selectedProducts))
            badgeView.isHidden = selectedProducts.isEmpty ? true : false
            cartLabel.text = "\(selectedProducts.count)"
        }
    }
    
    func loadProducts() -> [Product]{
        var jsonData: [Product] = []
        guard let filePath = Bundle.main.path(forResource: "products", ofType: "json") else { return [] }
        guard let data = try? Data(referencing: NSData(contentsOfFile: filePath)) else { return [] }
        do {
            jsonData = try JSONDecoder().decode([Product].self, from: data)
            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        return jsonData
    }
    
    func loadFilters() -> [(category: String, isEnabled: Bool)]{
        var tempFilter: [(category: String, isEnabled: Bool)] = []
        let categoryList: [String] = Array(Set(productList.map{ $0.category })).sorted(by: { $0 > $1 })
        tempFilter.append(("All", true))
        categoryList.forEach{ tempFilter.append(($0, false)) }
        return tempFilter
    }
    
    private func setupFilteredProduct(){
        if filterList.filter({ $0.category != "All" && $0.isEnabled }).isEmpty{ // no selected filters
            filteredProductList = productList
            return
        }else{
            let categoryList = filterList.filter({ $0.category != "All" && $0.isEnabled }).map{ $0.category }
            filteredProductList = productList.filter({ categoryList.contains($0.category) })
            return
        }
    }
    
    private lazy var addAlertView: AddAlertView = {
        let addAlertView = AddAlertView.instanceFromNib()
        addAlertView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 130, width: UIScreen.main.bounds.size.width, height: 130)
        return addAlertView
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowCartSegue":
            if let vc = segue.destination as? CartViewController{
                vc.cart = selectedProducts
                vc.delegate = self
            }
            return
        default:
            return
        }
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.data = filterList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            filterList = loadFilters()
            return
        }
        filterList[indexPath.row].isEnabled.toggle()
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.data = filteredProductList[indexPath.row]
        cell.addButton.onTapView = { [weak self] in
            self?.selectedProducts.append((self?.filteredProductList[indexPath.row])!)
            guard let alert = self?.addAlertView else { return }
            alert.product = self?.filteredProductList[indexPath.row].name ?? ""
            self?.view.addSubview(alert)
        }
        return cell
    }
    
}

extension ProductsViewController: CartViewControllerDelegate{
    func didTapBack(_ cart: [Product]) {
        selectedProducts = cart
    }
    
}

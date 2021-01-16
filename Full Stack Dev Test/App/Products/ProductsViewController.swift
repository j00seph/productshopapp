//
//  ViewController.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit

class ProductsViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productList = loadProducts()
        filterList = loadFilters()
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
        let categoryList: [String] = Array(Set(productList.map{ $0.category }))
        tempFilter.append(("All", true))
        categoryList.forEach{ tempFilter.append(($0, false)) }
        return tempFilter
    }
    
    var filterList: [(category: String, isEnabled: Bool)] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var productList: [Product] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    var selectedProducts: [Product] = []
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.filterLabel.text = filterList[indexPath.row].category
        return cell
    }
    
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.data = productList[indexPath.row]
        cell.addButton.onTapView = { [weak self] in
            self?.selectedProducts.append((self?.productList[indexPath.row])!)
        }
        return cell
    }
    
    
}

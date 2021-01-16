//
//  ViewController.swift
//  Full Stack Dev Test
//
//  Created by Joseph on 1/16/21.
//

import UIKit

class ProductsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
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
}


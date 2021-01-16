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

    
    func loadJson(jsonName: String) -> [Codable]{
        var jsonData: [Codable] = []
        guard let filePath = Bundle.main.path(forResource: "products", ofType: "json") else { return [] }
        guard let data = try? Data(referencing: NSData(contentsOfFile: filePath)) else { return [] }
        do {
            jsonData = try JSONDecoder().decode([Currency].self, from: data)
            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        return jsonData
        
        
    }
}


//
//  DataGatherer.swift
//  Bouji
//
//  Created by Soham Nagawanshi on 1/28/23.
//

import Foundation
import UIKit

class DataGatherer {
    private let baseUrl: String = "https://api.bluecartapi.com/request?api_key=5CB0CD08871545EC86197C1ED85E3F44&search_term="
    static let shared = DataGatherer()
    private init(){}
    func gatherData(item: String, completion: @escaping ([Product])->()) {
        let url = URL(string: baseUrl+item+"&type=search")
        print(url)
        if let url {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    print("An error has occured:\n\(error)")
                    
                } else if let data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let productData =  try jsonDecoder.decode(Result.self, from: data)
                        let products = self.gatherProducts(ProductData: Array(productData.search_results[...10]))
                        completion(products)
                    } catch {
                        print("An error has occured:\n\(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
}
//MARK: - gather appropriate
extension DataGatherer {
    func gatherProducts(ProductData: [SearchResult]) -> [Product] {
        var products: [Product] = []
        for product in ProductData {
            var newProduct: Product
            if let imageData = try? Data(contentsOf: product.product.main_image), let image = UIImage(data: imageData)  {
                let description = product.product.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "Description"
                newProduct = Product(name: product.product.title, price: product.offers.primary.price, description: description, image: image)
            } else {
                let description = product.product.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "Description"
                newProduct = Product(name: product.product.title, price: product.offers.primary.price, description: description, image: UIImage(systemName: "questionmark")!)
                newProduct = Product(name: product.product.title, price: product.offers.primary.price, description: "", image: UIImage(systemName: "questionmark")!)
                
            }
            products.append(newProduct)
        }
        return products
    }
}

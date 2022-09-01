//
//  ProductDetailsViewController.swift
//  eCommerce Application
//
//  Created by USER on 25/07/2022.
//

import UIKit

//For Downlode Image:
extension UIImageView {
    func downloaded1(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded1(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productDetailsTitelNameLbl: UILabel!
    @IBOutlet weak var productDetailsPriceLbl: UILabel!
    @IBOutlet weak var productDetailsProductImage: UIImageView!
    @IBOutlet weak var productDetailsDescriptionLbl: UILabel!
    @IBOutlet weak var productDetailsTextView: UITextView!
    @IBOutlet weak var rateLbl: UILabel!
    
    var productDetails : ProdectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productDetailsTitelNameLbl.text = "\(productDetails?.title ?? "")"
        productDetailsPriceLbl.text = "Price: \(productDetails?.price ?? 0.00) $"
        productDetailsTextView.text = "Description: \(productDetails?.description ?? "")"
        rateLbl.text = "Product Rating: \(productDetails?.rating?.rate ?? 0.0)/5"
        
   
        let urlString = productDetails?.image
        let url = URL (string: urlString!)
        productDetailsProductImage.downloaded1(from: url!)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addToCartBtnAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let pcovc = storyboard!.instantiateViewController(identifier: "ProductCheckOutViewController")as! ProductCheckOutViewController
        pcovc.productChackOut = productDetails
        self.navigationController?.pushViewController(pcovc, animated: true)
    }
    
}

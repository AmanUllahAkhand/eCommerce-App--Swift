//
//  ProductCheckOutViewController.swift
//  eCommerce Application
//
//  Created by USER on 25/07/2022.
//

import UIKit
//For Downlode Image:
extension UIImageView {
    func downloaded2(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloaded2(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class ProductCheckOutViewController: UIViewController {
   

    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var qutTextField: UITextField!
    @IBOutlet weak var prodectNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var okBtnok: UIButton!
    @IBOutlet weak var productCheckoutTotalPriceLbl: UILabel!
    
    var productChackOut : ProdectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        prodectNameLbl.text = productChackOut?.title
        priceLbl.text = "\(productChackOut?.price ?? 0.00 )"
        
        let urlString = productChackOut?.image
        let url = URL (string: urlString!)
        productImage.downloaded2(from: url!)
        
    }
   
 
    @IBAction func okBtnAction(_ sender: Any) {
        
        let a = Double(qutTextField.text!)
        let b = Double(priceLbl.text!)
        
        if qutTextField.text!.isEmpty && ((priceLbl.text?.isEmpty) != nil){
            totalAmountLbl.text = "0.00"
        }
        else{
            let c = Double(a!*b!)
            totalAmountLbl.text = "Total Amount: \(c) $"
        }
     //Keyboard Dismiss
        qutTextField.resignFirstResponder()
        productCheckoutTotalPriceLbl.text = totalAmountLbl.text
        
    }
    
    @IBAction func productCheckoutPaymentBtnAction(_ sender: Any) {
        
        
    }
    

}

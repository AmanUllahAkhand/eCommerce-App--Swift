//
//  ProductListViewController.swift
//  eCommerce Application
//
//  Created by USER on 25/07/2022.
//

import UIKit
//For Downlode Image:
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class ProductListViewController: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var productListSearchBar: UISearchBar!
    @IBOutlet weak var categorNameLbl: UILabel!
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    var productCategory  = ""
    
    
    private let productRepository = E_CommerceProduct()
    private var myData : [ProdectModel]? = []
    private var myDataTemp : [ProdectModel]? = []
    var custID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categorNameLbl.text = "\(productCategory.capitalized)"
        
        if categorNameLbl.text == "Jewelery" {
            custID = "products/category/jewelery"
        } else if categorNameLbl.text == "Electronics" {
                custID = "products/category/electronics" 
        } else if categorNameLbl.text == "Men's Clothing" {
            custID = "products/category/men's%20clothing"
        } else if categorNameLbl.text == "Women's Clothing" {
            custID = "products/category/women's%20clothing"
        }
            
        //searchbar.......
          productListSearchBar.delegate = self
          myDataTemp = myData
        
        setupContainer()
        loadMyData()
 
    }
 
    func setupContainer(){
        self.productListCollectionView.delegate = self
        self.productListCollectionView.dataSource = self
        self.productListCollectionView.reloadData()
      
    }

    func loadMyData() {
        productRepository.getE_CommerceProduct (custId: custID){ success in
            print(success)

            self.myData = success
            self.myDataTemp = self.myData
            self.productListCollectionView.reloadData()

        }
    }
 
}
 
extension ProductListViewController :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDataTemp!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        if let md = myDataTemp?[indexPath.row] {
            cell.productListProductPrice.text = " \(md.price ?? 0.00)$"
            cell.productListProductNameLbl.text = "\(md.title ?? "")"
            
            let urlString = md.image
            let url = URL (string: urlString!)
            cell.productListProductImage.downloaded(from: url!)
           

        }

        return cell
    }
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let width = collectionView.bounds.size.width/2 - 5
       let height = collectionView.bounds.size.height/2
        return CGSize(width: width , height: height)
    }
    
    
    }
    
extension ProductListViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let pdvc = storyboard!.instantiateViewController(identifier: "ProductDetailsViewController")as! ProductDetailsViewController
        
        if let md = myDataTemp?[indexPath.row] {
            pdvc.productDetails = md
        }
       
        self.navigationController?.pushViewController(pdvc, animated: true)
}
    
    
    // SearchBar.......
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            myDataTemp = myData
            productListCollectionView.reloadData()
        } else {
            myDataTemp?.removeAll()
            if let productData = myData {
                for product in productData {
                    if let name = product.title {
                        if name.lowercased().contains(searchText.lowercased()) {
                            myDataTemp?.append(product)
                        }
                    }
                    
                }
            }
            self.productListCollectionView.reloadData()
        }

   }

    
}

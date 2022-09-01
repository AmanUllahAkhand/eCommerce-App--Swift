//
//  ViewController.swift
//  eCommerce Application
//
//  Created by USER on 25/07/2022.
//

import UIKit

class ViewController: UIViewController{

   
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var namelbl: UILabel!
    
    private let categoryRepository = E_CommerceCategory()
    private var category : [String]? = []
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        setupContainer()
        loadMyData()
 
    }
 
    func setupContainer(){
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.reloadData()
      
    }

    func loadMyData() {
        categoryRepository.getE_CommerceCategory (custId: "products/categories"){ success in
            print("ASDFF:\(success)")

            self.category = success
            self.categoryCollectionView.reloadData()

        }
    }
 
}

extension ViewController :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        cell.categoryNameLbl.text = "\(category![indexPath.item].capitalized)"

        if cell.categoryNameLbl.text == "Jewelery" {
            cell.categoryImage.image = UIImage(named: "Jewellery")
        } else if cell.categoryNameLbl.text == "Electronics" {
            cell.categoryImage.image = UIImage(named: "Electronics")
        } else if cell.categoryNameLbl.text == "Men's Clothing" {
            cell.categoryImage.image = UIImage(named: "Men'sClothing")
        } else if cell.categoryNameLbl.text == "Women's Clothing" {
            cell.categoryImage.image = UIImage(named: "women'sClothing")
        }

        return cell
    }
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let width = collectionView.bounds.size.width/2 - 5
       let height = collectionView.bounds.size.height/3
        return CGSize(width: width , height: height)
       }
   }
    
extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let plvc = storyboard!.instantiateViewController(identifier: "ProductListViewController")as! ProductListViewController
        
        if let categoryData = category?[indexPath.item]{
            plvc.productCategory = categoryData
        }
      
        self.navigationController?.pushViewController(plvc, animated: true)
  }
    

    
}

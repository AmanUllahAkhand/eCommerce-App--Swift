//
//  ProfileViewController.swift
//  eCommerce Application
//
//  Created by USER on 25/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var profileMobileNumberLbl: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileAddress: UILabel!
    @IBOutlet weak var changeProfileImageBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        changeProfileImageBtn.isHidden = true
        takePhotoBtn.isHidden = true
        
        // Do any additional setup after loading the view.
        self.profileNameLbl.text = "Name:Aman Ullah Akhand"
        self.profileMobileNumberLbl.text = "Phone Number: +88 01783 901 510"
        self.profileEmail.text = "Email: amanullah.iOS2005@gmail.com"
        self.profileAddress.text = "Address: 7/3 Shahjadpur, Gulshan 2, Dhaka."
       
        //  RoundImage
        profileImage.layer.cornerRadius = profileImage.layer.bounds.height/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
        //   Border
        profileImage.layer.borderWidth = 10
        profileImage.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func changeProfilePic(_ sender: Any) {
        changeProfileImageBtn.isHidden = false
        takePhotoBtn.isHidden = false
    }
    
    @IBAction func changProfileImageBtnAction(_ sender: Any) {
        takePhotoBtn.isHidden = true
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.modalPresentationStyle = .overFullScreen
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        changeProfileImageBtn.isHidden = true
      
    }
    @IBAction func takePhotoBtnAction(_ sender: Any) {
        takePhotoBtn.isHidden = true
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.modalPresentationStyle = .overFullScreen
        vc.allowsEditing = true
        changeProfileImageBtn.isHidden = true
        vc.delegate = self
        present(vc,animated: true)
    }
    
}
extension ProfileViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else{
            print("No Image Found")
            return
        }
        print(image.size)
        picker.dismiss(animated: true){
            self.profileImage.image = image

            
        }
    }
}


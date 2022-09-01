//
//  CategoryRepository.swift
//  eCommerce Application
//
//  Created by USER on 26/07/2022.
//

import UIKit

class E_CommerceCategory {
 
    func getE_CommerceCategory( custId: String,completion: @escaping (_ success:[String]) -> Void) {
        
        let fullUrl = AllApi.API + "\(custId)"
        print(fullUrl)
        var request = URLRequest(url: URL(string: fullUrl)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 120 // 120 sec
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let myData = data, error == nil else { return }
            do {
                print(myData)
                let responseModel: [String] = try JSONDecoder().decode([String].self, from: myData )
                DispatchQueue.main.async {
                    completion(responseModel)
                }
            } catch let err {
                print(err)
            }
        }.resume()
         
    } }

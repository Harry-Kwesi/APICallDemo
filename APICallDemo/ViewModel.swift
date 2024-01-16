//
//  ViewModel.swift
//  APICallDemo
//
//  Created by Harry Kwesi De Graft on 16/01/24.
//

import Foundation
import SwiftUI

struct Meal : Hashable, Codable, Identifiable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb : String
    let strCategoryDescription: String
    
    var id: String { idCategory }
}

class ViewModel : ObservableObject{
    @Published var meals: [Meal] = []
    
    func fetch() {
        guard let url = URL (string: "https://www.themealdb.com/api/json/v1/1/categories.php")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _ ,
            error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let response = try JSONDecoder().decode([String: [Meal]].self, from: data)
                            
                            if let meals = response["categories"] {
                                DispatchQueue.main.async {
                                    self?.meals = meals
                                }
                            }
            }
            catch{
                print(error)
            }
           
        }
        task.resume()
    }
}


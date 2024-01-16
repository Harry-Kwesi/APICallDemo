//
//  ContentView.swift
//  APICallDemo
//
//  Created by Harry Kwesi De Graft on 16/01/24.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View{
        
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .background(Color.gray)
                    .cornerRadius(3)
        }
        else{
            
        Image(systemName: "video")
                .resizable()
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
            
              }
    }
    
    private func fetchData(){
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, _,
            _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.meals){ meal in
                    HStack {
                        URLImage(urlString: meal.strCategoryThumb)
                                            
                            Text("\(meal.strCategory)")
                                    .bold()
                        
                            }
                            .padding(10)
                }
            }
            .navigationTitle("Meals")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    ContentView()
}

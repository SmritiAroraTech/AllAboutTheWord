//
//  APIRequest.swift
//  AllAboutTheWord
//
//  Created by Nineleaps on 03/11/21.
//

import Foundation

class APIRequest: ObservableObject {
    @Published var wordData: [WordDetails] = []
    func getWordData(forWord text:String, completionHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(text)") else { fatalError("Missing Url")  }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode([WordDetails].self, from: data)
                        self.wordData = decodedData
                        completionHandler("Request completed")
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        task.resume()
    }
}

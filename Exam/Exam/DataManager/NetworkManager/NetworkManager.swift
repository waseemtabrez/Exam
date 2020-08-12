//
//  NetworkManager.swift
//  Exam
//
//  Created by Waseem on 12/08/20.
//  Copyright © 2020 Waseem. All rights reserved.
//


import Foundation

struct NetworkManager {
   
   private init() {}
   static let shared = NetworkManager()
   
   private let urlSession = URLSession.shared
   private let baseURL = URL(string: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld")!
   
   func getDataFromServer(completion: @escaping(_ gnomes: ExamApiResponse?, _ error: Error?) -> ()) {
      let filmURL = baseURL
      urlSession.dataTask(with: filmURL) { (data, response, error) in
         if let error = error {
            completion(nil, error)
            return
         }
         
         guard let data = data else {
            completion(nil, error)
            return
         }
         
         do {
            let result = try JSONDecoder().decode(ExamApiResponse.self, from: data)
            completion(result, nil)
         } catch {
            print("Error parsing the JSON: \(error)")
            completion(nil, error)
         }
      }.resume()
   }
}

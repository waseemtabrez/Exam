//
//  DataVM.swift
//  Exam
//
//  Created by Waseem on 12/08/20.
//  Copyright © 2020 Waseem. All rights reserved.
//

import Foundation

class DataVM: ObservableObject {
    @Published var data: ExamApiResponse = ExamApiResponse()
    
    func setTheFetchedData() {
        NetworkManager.shared.getDataFromServer(completion: {(result, error) in
            guard let error = error else {
                DispatchQueue.main.async {
                    self.data = result ?? ExamApiResponse()
                }
                print(result! as ExamApiResponse)
                return
            }
            print(error)
            return
        })
    }
}

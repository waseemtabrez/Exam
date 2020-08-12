//
//  Models.swift
//  Exam
//
//  Created by Waseem on 12/08/20.
//  Copyright © 2020 Waseem. All rights reserved.
//

import Foundation

struct ChartData: Codable, Hashable {
    var text: String?
    var percentage: Int?
    
    enum CodingKeys: String, CodingKey {
       case text = "text"
       case percentage = "percetnage"
    }
}
struct QuestionsModel: Codable, Hashable {
    var total: Int?
    var text: String?
    var chartData: [ChartData]?
    
    enum CodingKeys: String, CodingKey {
       case text = "text"
       case total = "total"
       case chartData = "chartData"
    }
}

struct ExamApiResponse: Codable {
   var colors: [String]?
   var questions: [QuestionsModel]?
    
   enum CodingKeys: String, CodingKey {
      case questions = "questions"
      case colors = "colors"
   }
}

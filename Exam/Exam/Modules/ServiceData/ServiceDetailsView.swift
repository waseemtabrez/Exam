//
//  ServiceDetailsView.swift
//  Exam
//
//  Created by Waseem on 12/08/20.
//  Copyright © 2020 Waseem. All rights reserved.
//

import SwiftUI

let emptyString = ""
struct ServiceDetailsView: View {
    @ObservedObject var data: ServiceVM
    var body: some View {
        NavigationView {
            VStack {
                ForEach(self.data.data.questions ?? [QuestionsModel](), id: \.self) { item in
                    ServiceDetailCellView(question: item).padding().cornerRadius(20)
                }
            }.background(Color(UIColor.systemGray6))
            .onAppear{
                self.data.setTheFetchedData()
            }
        .navigationBarTitle("Graphics")
        }
    }
}

struct ServiceDetailCellView: View {
    @State var question = QuestionsModel()
    
    var body: some View {
        VStack {
            HStack{
                Text("\(self.question.text ?? emptyString)").padding(.horizontal).font(.headline)
                Spacer()
            }
            ForEach(self.question.chartData ?? [ChartData](), id: \.self){ item in
                HStack{
                    Text("\(item.text ?? emptyString)").font(.caption).foregroundColor(Color.secondary)
                    Text("\(item.percentage ?? 0)").font(.caption).foregroundColor(Color.secondary)
                    Spacer()
                }.padding(.horizontal)
            }
        }
    }
}

struct PieChartView: View {
    @State var question = QuestionsModel()
    var body: some View {
        VStack {
            ForEach(self.question.chartData ?? [ChartData](), id: \.self){ item in
                
                HStack{
                    Text("\(item.text ?? emptyString)")
                    Text("\(item.percentage ?? 0)")
                }
            }
            Spacer()
        }
    }
}

//TODO
struct DrawShape: View {
    
    var centre: CGPoint
//    var index: Int
    var chartData: ChartData?
    
    func to() -> Double {
        var temp = 0.0
//        for indx in (0...self.index) {
            temp += Double(chartData?.percentage ?? 0) * 360
//        }
        return temp
    }
    
    func from() -> Double {
//        if self.index == 0 {
//            return 0
//        } else {
            var temp = 0.0
//            for indx in (0...self.index - 1) {
                temp += Double(chartData?.percentage ?? 0) * 360
//            }
            return temp
//        }
    }
    
    var body: some View {
        Path { path in
            path.move(to: self.centre)
            path.addArc(center: self.centre, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
        }.fill(Color.black)
    }
}

struct ServiceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailsView(data: ServiceVM())
    }
}

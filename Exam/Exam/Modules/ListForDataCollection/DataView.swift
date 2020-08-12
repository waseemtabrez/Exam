//
//  DataView.swift
//  Exam
//
//  Created by Waseem on 12/08/20.
//  Copyright © 2020 Waseem. All rights reserved.
//

import SwiftUI

struct DataView: View {
    @ObservedObject var dataVM: DataVM = DataVM()
    var body: some View {
        Text("Hwllo").onAppear{
            self.dataVM.setTheFetchedData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}

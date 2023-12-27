//
//  TestVuew.swift
//  Timer
//
//  Created by lkh on 12/27/23.
//

import SwiftUI

struct TestView: View {
    let items = [1,2]
    var body: some View {
        List {
            ForEach(items, id:\.self) { item in
                HStack {
                    
                    Text("버튼 1")
                        .onTapGesture {
                            print("1")
                        }
                    
                    Text("버튼 2")
                        .onTapGesture {
                            print("1")
                        }
                }
            }
        }
    }
}

#Preview {
    TestView()
}

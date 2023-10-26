//
//  WodView.swift
//  Timer
//
//  Created by lkh on 10/25/23.
//

import SwiftUI

struct WodView: View {
    @ObservedObject var vm = MovementsViewModel()
    
    @State private var runnigBtn: Bool = true
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Text("\(vm.curMovement.name)")
                    
                    Text("\(vm.currentTime)")
                        .onReceive(timer) { time in
                            if runnigBtn {
                                vm.currentTime += 1
                            }
                        }
                    // forward.fill
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "backward.fill")
                                .font(.system(size: 50))
                        }
                        
                        Button(action: {
                            runnigBtn.toggle()
                        }) {
                            Image(systemName: runnigBtn ? "pause.circle" : "play.circle")
                                .font(.system(size: 50))
                        }
                        Button(action: {
                            
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.system(size: 50))
                        }
                    }
                    .padding()
                    
                    
                    Spacer()
                    
                    Button(action: btnPressed, label: {Text("next!!")})
                        .modifier(btnCustom())
                        .frame(width: geometry.size.width)
                }
                .padding()
            }
        }
    }
    
    func btnPressed() {
        vm.StartPressed()
    }
}

#Preview {
    WodView()
}

//
//  TimerNaviView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct TimerNaviView: View {
    @StateObject var vm = MovementsViewModel()
    @State private var startBtn = false
    @State private var inputName: String = ""
    @State private var inputDetail: String = ""
    @State private var inputAim: String = ""
    
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    HStack {
                        VStack {
                            TextField(
                                "name: ex) push-up",
                                text: $inputName
                            )
                            .submitLabel(.done)
                            .onSubmit {
                                
                            }
                            TextField(
                                "detail: ex) rep Or meter Or lb",
                                text: $inputDetail
                            )
                            .submitLabel(.done)
                            .onSubmit {
                                
                            }
                            TextField(
                                "Target Time: ex) 30",
                                text: $inputAim
                            )
                            .submitLabel(.done)
                            .onSubmit {
                                
                            }
                        }
                        
                        Button(action: {
                            // inputName과 inputRepOrMeter 값을 전달하여 더미를 추가
                            vm.addPressed(InputMovements(name: inputName, detail: inputDetail, aim: inputAim))
                            // 입력 필드 초기화
                        }, label: {Text("add")})
                        .modifier(btnCustom())
                        //                        .frame(width: geometry.size.width)
                    }.padding()
                    
                    List(vm.wodArr) { wod in
                        HStack {
                            Text(wod.name)
                            
                            Button(action: {
                                vm.deletePressed(wod)
                            }) {
                                Image(systemName: "x.circle.fill")
                                    .font(.system(size: 20))
                            }
                        }
                    }
                    
                    NavigationLink("", destination: WodView(vm: vm), isActive: $startBtn)
                    
                    Button(action: btnPressed, label: {Text("Start!!")})
                        .modifier(btnCustom())
//                        .frame(width: geometry.size.width)
                    
                }
            }
            .padding()
        }
    }
    
    func btnPressed() {
        startBtn = true
        vm.FirstStartPressed()
    }
}

#Preview {
    TimerNaviView()
}

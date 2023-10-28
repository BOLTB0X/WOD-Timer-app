//
//  MainView.swift
//  Timer
//
//  Created by lkh on 10/27/23.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView {
            WodInterView()
                .tabItem {
                    Image(systemName: "figure.highintensity.intervaltraining")
                }
            
            GeneralView()
                .tabItem {
                    Image(systemName: "timer")
                }
        }
//        ZStack(alignment: .bottom) {
//            TabView(selection: $selectedTab) {
//                WodInterView()
//                    .tag(0)
//                
//                PassivityView()
//                    .tag(1)
//                
//                GeneralView()
//                    .tag(2)
//                
//                ProfileView()
//                    .tag(3)
//            }
//            
//                        ZStack{
//                            HStack{
//                                ForEach((TabbedItems.allCases), id: \.self){ item in
//                                    Button{
//                                        selectedTab = item.rawValue
//                                    } label: {
//                                        CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
//                                    }
//                                }
//                            }
//                            .padding(6)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 70)
//                        .background(.blue.opacity(0.2))
//                        .cornerRadius(35)
//                        .padding(.horizontal, 26)
//                        .padding(.bottom, 0)
//        }
    }
}

extension MainView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? nil : 60, height: 60)
        .background(isActive ? .blue.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}

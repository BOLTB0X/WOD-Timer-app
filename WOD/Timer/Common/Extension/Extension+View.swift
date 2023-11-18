//
//  Extension+View.swift
//  Timer
//
//  Created by lkh on 11/6/23.
//

import SwiftUI

extension View {
    // MARK: - popupNavigationView
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, @ViewBuilder content: @escaping ()->Content) -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .overlay {
                if show .wrappedValue {
                    GeometryReader { proxy in
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView {
                            VStack(alignment: .center, spacing: 0) {
                                content()
                                Spacer()
                            }
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / 2.5, alignment: .top)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
    
    // MARK: - popupToolbar
    func popupSettingToolbar(action1: @escaping () -> Void, text: String, action2: @escaping () -> Void) -> some View {
        toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { withAnimation { action1() } }) {
                    Image(systemName: "xmark").foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { withAnimation { action2() } }) {
                    Text(text)
                }
            }
        }
    }
    
    // MARK: - hideKeyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

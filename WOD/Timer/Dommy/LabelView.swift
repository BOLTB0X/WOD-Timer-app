//
//  LabelView.swift
//  Timer
//
//  Created by lkh on 12/2/23.
//

import SwiftUI
import UIKit

struct CustomLabel: UIViewRepresentable {
    var text: String
    var fontSize: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
        uiView.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
    }
}

struct LabelView: View {
    var body: some View {
        VStack {
            CustomLabel(text: "HelloSwiftUI!", fontSize: 60)
                .frame(width: 200, height: 500)
                .background(Color.gray)
        }
    }
}

#Preview {
    LabelView()
}

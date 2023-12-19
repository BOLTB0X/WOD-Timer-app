//
//  WidgetManager.swift
//  Timer
//
//  Created by KyungHeon Lee on 2023/12/19.
//

import Foundation

class WidgetManager: ObservableObject {
    @Published var contentState = TimerWidgetAttributes.ContentState(currentDisplayTime: 0)
    
}

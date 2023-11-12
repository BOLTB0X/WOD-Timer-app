//
//  KeyboardManager.swift
//  Timer
//  https://github.com/TuenTuenna/keyboard_monitor_tutorial/blob/main/keyboard_event_tutorial_swiftui/keyboard_event_tutorial/KeyboardMonitor.swift
//  Created by lkh on 11/10/23.
//

import Foundation
import Combine
import UIKit

final class KeyboardMonitor : ObservableObject {
    
    enum Status {
        case show, hide
        var description : String {
            switch self {
            case .show: return "보임"
            case .hide: return "안보임"
            }
        }
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    //    @Published var updatedKeyboardStatusAction : Status = .hide
    @Published var keyboardHeight : CGFloat = 0.0
    
    lazy var updatedKeyboardStatusAction : AnyPublisher<Status, Never> = $keyboardHeight
        .map { (height : CGFloat) -> KeyboardMonitor.Status in
            return height > 0 ? .show : .hide
        }.eraseToAnyPublisher()
    
    init(){
        print("KeyboardMonitor - init() called")
        
        /// 키보드 올라온 이벤트 처리 -> 키보드 높이
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
            .compactMap { (noti : Notification) -> CGRect in
                return noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            }.map{ (keyboardFrame : CGRect) -> CGFloat in
                return keyboardFrame.height
            }.subscribe(Subscribers.Assign(object: self, keyPath: \.keyboardHeight))
        
        /// 키보드 내려갈때 이벤트 처리 -> 키보드 높이
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
            .compactMap { (noti : Notification) -> CGFloat in
                return .zero
            }.subscribe(Subscribers.Assign(object: self, keyPath: \.keyboardHeight))
    }
}

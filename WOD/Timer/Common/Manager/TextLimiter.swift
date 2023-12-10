//
//  TextMonitor.swift
//  Timer
//
//  Created by lkh on 11/26/23.
//

import Foundation

// MARK: - TextMonitor
class TextManager: ObservableObject {
    private let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    @Published var value: String = "" {
        didSet {
            if value.count > 1 && value.first! == "0" {
               value = String(value.prefix(1))
           }
            
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.isReachedLimit = true
            } else {
                self.isReachedLimit = false
            }
        }
    }
    
    @Published var isReachedLimit: Bool = false
}

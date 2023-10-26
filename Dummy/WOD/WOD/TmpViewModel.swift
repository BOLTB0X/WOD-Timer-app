//
//  TmpViewModel.swift
//  WOD
//
//  Created by KyungHeon Lee on 2023/10/22.
//

import Foundation
import Combine

class TmpViewModel: ObservableObject {
    @Published var isBtn: Bool = false
        
    public func play() {
        isBtn = isBtn ? false : true
    }
    
}

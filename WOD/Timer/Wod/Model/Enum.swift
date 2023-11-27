//
//  Enum.swift
//  Timer
//
//  Created by lkh on 11/18/23.
//

import Foundation

enum SimpleButton {
    case round
    case preparation
    case movements
    case rest

    var buttonText: String {
        switch self {
        case .round:
            return "Round"
        case .preparation:
            return "Preparation"
        case .movements:
            return "Movements"
        case .rest:
            return "Rest"
        }
    }
}

enum ScenePhase {
    case active
    case inactive
    case background
}

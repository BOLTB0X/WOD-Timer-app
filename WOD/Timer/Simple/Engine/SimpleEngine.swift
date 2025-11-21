//
//  CountingEngine.swift
//  Timer
//
//  Created by KyungHeon Lee on 11/21/25.
//

import Foundation
import Combine

// MARK: - SimpleEngine
protocol SimpleEngine: ObservableObject, AnyObject {
    var roundArray: [SimpleRound] { get set }
    var roundTotalTime: Int { get }
    var roundIndex: Int? { get set }
    
    var displayTime: Int { get set }
    
    var engineState: TimerState { get set }
    var cancellable: AnyCancellable? { get set }
    
    func start()
    func pause()
    func resume()
    func completed(completionHook: (() -> Void)?)
    func canclled(cancelHook: (() -> Void)?)
    
} // SimpleEngine

// MARK: - impl
extension SimpleEngine {
    
    // MARK: - pause
    func pause() {
        cancellable?.cancel()
    } // pause
    
    // MARK: - resume
    func resume() {
        engineState = .active
    } // resume
    
    // MARK: - completed
    func completed(completionHook: (() -> Void)? = nil) {
        cancellable?.cancel()
        engineState = .completed
        
        completionHook?()
    } // completed
    
    // MARK: - canclled
    func canclled(cancelHook: (() -> Void)? = nil) {
        engineState = .cancelled
        roundIndex = nil
        
        cancelHook?()
    } // canclled
    
} // impl


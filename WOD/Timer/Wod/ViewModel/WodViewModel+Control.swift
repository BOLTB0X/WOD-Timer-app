//
//  WodViewModel+Control.swift
//  Timer
//
//  Created by lkh on 12/3/23.
//

import Foundation

// MARK: - WodViewModel+SimpleTimer: SimpleTimer Control
extension WodViewModel {
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
        guard let _ = simpleRoundIdx else {
            return
        }
        
        if simpleState == .paused || simpleState == .resumed {
            resumeSimpleTimer()
        } else {
            pauseSimpleTimer()
        }
        return
    }
    
    // MARK: - controlBefore
    // 그 이전으로 되돌아가기
    func controlBefore() {
        
    }
    
    // MARK: - controlNext
    // 뒤로(다음) 가기
    func controlNext() {
        
    }
}

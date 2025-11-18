//
//  SoundManager.swift
//  Timer
//
//  Created by lkh on 12/9/23.
//

import AVFoundation

// MARK: - AVManager
actor AVManager: NSObject, AVAudioPlayerDelegate {
    static let shared = AVManager()
    
    private var audioPlayer: AVAudioPlayer?
    private var continuation: CheckedContinuation<Void, Error>?
    
    // MARK: - playSound
    // async/await 재생 — 똑같은 파일을 재생하고 끝날 때 리턴
    func playSound(named fileName: String, fileExtension: String) async throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            throw NSError(domain: "AVManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to find file \(fileName).\(fileExtension)"])
        }
        
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        
        try await withCheckedThrowingContinuation { (c: CheckedContinuation<Void, Error>) in
            continuation = c
        }
    } // playSound
    
    // MARK: - playSoundSync
    // legacy 호출용 편의 메서드 (비동기 호출을 내부 Task로 래핑)
    nonisolated func playSoundSync(named fileName: String, fileExtension: String) {
        Task {
            try? await AVManager.shared.playSound(named: fileName, fileExtension: fileExtension)
        }
    }
    
    // MARK: - AVAudioPlayerDelegate
    // ...
    
    nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Task { @MainActor in
            await self.finishPlaying(success: flag)
        }
    } // audioPlayerDidFinishPlaying
    
    nonisolated func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        Task { @MainActor in
            await self.handleError(error: error)
        }
    } // audioPlayerDecodeErrorDidOccur
    
    // MARK: - finishPlaying
    private func finishPlaying(success: Bool) {
        if success {
            continuation?.resume()
        } else {
            // 성공하지 못한 경우, continuation을 resume(throwing: )으로 처리하여 종료
            continuation?.resume(throwing: NSError(domain: "AVManager", code: -3, userInfo: [NSLocalizedDescriptionKey: "Playback unsuccessful"]))
        }
        continuation = nil
    } // finishPlaying
    
    // MARK: - handleError
    private func handleError(error: Error?) {
        continuation?.resume(throwing: error ?? NSError(domain: "AVManager", code: -2))
        continuation = nil
    } // handleError
    
} // AVManager


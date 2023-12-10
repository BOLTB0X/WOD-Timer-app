//
//  SoundManager.swift
//  Timer
//
//  Created by lkh on 12/9/23.
//

import AVFoundation

// MARK: - AVManager
// 효과음 관련
class AVManager {
    static let shared = AVManager()
    
    private var audioPlayer: AVAudioPlayer?
        
    func playSound(named fileName: String, fileExtension: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("실패 \(fileName).\(fileExtension)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch let error {
            print("error.localizedDescription: \(error.localizedDescription)")
        }
    }
}


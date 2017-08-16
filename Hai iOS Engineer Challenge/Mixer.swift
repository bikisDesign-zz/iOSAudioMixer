//
//  Mixer.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/16/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import Foundation
import AVFoundation

final class Mixer: NSObject, AVAudioPlayerDelegate {
  
  private var player: AVAudioPlayer?
  
  private lazy var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
  
  enum MixerStatus {
    case booting, readyToPlay, isPlaying
  }
  
  private var maxVolume: Float = 1.0
  
  private var volumeIncrement: Float = 0.2
  
  var status: MixerStatus = .booting
  
  override init() {
    super.init()
    do {
      try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
      try audioSession.setActive(true)
    } catch {
      assertionFailure("couldn't set avaudioSessionCategory")
    }
  }
  
  
  func setupPlayer(with audio: Data) throws {
    player = try AVAudioPlayer(data: audio)
    player?.volume = 1.0
    player?.delegate = self
    player?.prepareToPlay()
    status = .readyToPlay
  }
  
  
  func startPlayback() -> Bool {
    guard status == .readyToPlay else {
      print("mixer isn't ready to play yet")
      return false
    }
    player?.play()
    status = .isPlaying
    return true
  }
  
  
  func stopPlayback() -> Bool {
    
    guard status == .isPlaying else {
      print("mixer is not playing")
      return false
    }
    
    player?.stop()
    player?.currentTime = 0.0
    status = .readyToPlay
    return true
  }
  
  
  /// if is at max or at min allowed volume it will return false
  /// otherwise will perform volume change and return true
  func setVolume(up isUP: Bool) -> Bool {
    let volume = isUP ? player!.volume + volumeIncrement : player!.volume - volumeIncrement
    
    if isUP {
      if volume > 1.0 {
      player?.setVolume(1.0, fadeDuration: 0.25)
      return false
      }
      
      player?.setVolume(volume, fadeDuration: 0.25)
      return true
    }
    
    if volume < 0.0 {
      player?.setVolume(0.0, fadeDuration: 0.25)
      return false
    }
    
    player?.setVolume(volume, fadeDuration: 0.25)
    return true
  }
}

//
//  PlaybackDeck.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/16/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit

protocol PlaybackDeckViewDelegate: class {
  func onPlaybackTap(withItem item: PlaybackDeckView.Item)
}

class PlaybackDeckView: UIView {
  
  weak var delegate: PlaybackDeckViewDelegate?
  
  enum Item {
    case volumeUp, volumeDown, playback
  }
  
  var isPlaying = false {
    didSet {
      play.image = isPlaying ? #imageLiteral(resourceName: "pause") : #imageLiteral(resourceName: "playback")
    }
  }
  
  private lazy var volumeDown: UIImageView = self.imageViewFactory(#imageLiteral(resourceName: "substract"))
  
  private lazy var play: UIImageView = self.imageViewFactory(#imageLiteral(resourceName: "playback"))
  
  private lazy var volumeUp: UIImageView = self.imageViewFactory(#imageLiteral(resourceName: "add"))
  
  private lazy var downButton: UIButton = self.buttonFactory()
  
  private lazy var playButton: UIButton = self.buttonFactory()
  
  private lazy var upButton: UIButton = self.buttonFactory()
  
  
  private func imageViewFactory(_ image: UIImage) -> UIImageView {
    let iv = UIImageView(image: image)
    iv.contentMode = .scaleAspectFit
    iv.isUserInteractionEnabled = true
    addSubview(iv)
    return iv
  }
  
  private func buttonFactory() -> UIButton {
    let button = UIButton()
    button.addTarget(self, action: #selector(onItemTap(sender:)), for: .touchUpInside)
    addSubview(button)
    return button
  }
  
  
  override func layoutSubviews() {
    let width = frame.width / 3 - 20
    
    volumeDown.frame = CGRect(x: 0, y: 0,
                            width: width, height: frame.height)
    
    downButton.frame = volumeDown.frame
    
    play.frame = CGRect(x: frame.width / 2 - width / 2, y: 0,
                        width: width, height: frame.height)
    
    playButton.frame = play.frame
    
    volumeUp.frame = CGRect(x: frame.width - width, y: 0,
                            width: width, height: frame.height)
    
    upButton.frame = volumeUp.frame
  }
  
  
  @objc private func onItemTap(sender: UIButton){
    if sender == upButton {
            delegate?.onPlaybackTap(withItem: .volumeUp)
    }
    if sender == downButton {
      delegate?.onPlaybackTap(withItem: .volumeDown)
    }
    
    if sender == playButton {
      delegate?.onPlaybackTap(withItem: .playback)
    }
  }
}



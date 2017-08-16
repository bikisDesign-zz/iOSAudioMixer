//
//  MusicPreviewVC.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SVNBootstraper
import SVNShapesManager


class MusicPreviewViewController: CoordinatableViewController {
  
  var result: SearchMeta
  
  private lazy var closeMeta: SVNShapeMetaData = SVNShapeMetaData(shapes: nil, location: SVNShapeLocation.topLeft, // defines the meta data for the shape we'd like to create
                                                          padding: CGPoint(x: 15, y: 25), size: CGSize(width: 65, height: 65),
                                                          fill: UIColor.clear.cgColor, stroke: Theme.Colors.darkText.color.cgColor, strokeWidth: 2.5)
  
  private lazy var exitButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(onExitTap), for: .touchUpInside)
    self.view.addSubview(button)
    return button
  }()
  
  private lazy var shapeManger: SVNShapesManager = SVNShapesManager(container: self.view.bounds)
  
  lazy var artistPreview: ArtistMetaView = {
    let preview = ArtistMetaView(result: self.result)
    self.view.addSubview(preview)
    return preview
  }()
  
  fileprivate lazy var playbackDeck: PlaybackDeckView = {
    let deck = PlaybackDeckView()
    deck.delegate = self
    self.view.addSubview(deck)
    return deck
  }()
  
  
  
  init(result: SearchMeta){
    self.result = result
    super.init()
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  override func viewDidLayoutSubviews() {
  
    let artistPreviewHeight: CGFloat = 200
    let playbackXPadding = view.frame.width / 4
    let playbackWidth =  view.frame.width - playbackXPadding * 2
    let playbackYPadding: CGFloat = 35
    let playbackDeckHeight = playbackWidth / 3
    
    artistPreview.frame = CGRect(x: 0, y: view.frame.height / 2 - (artistPreviewHeight + playbackDeckHeight + playbackYPadding) / 2,
                                 width: view.frame.width, height: artistPreviewHeight)
    
    
    
    playbackDeck.frame = CGRect(x: playbackXPadding, y: artistPreview.frame.origin.y + artistPreview.frame.size.height + playbackYPadding,
                                width: playbackWidth, height: playbackDeckHeight)
  
    
    exitButton.frame = CGRect(x: 0, y: 0, // set it to be larger than the exit layer so it's easier to tap
                              width: 85, height: 85)
    
    closeMeta.shapes?.forEach({ $0.removeFromSuperlayer() })
    closeMeta.shapes = nil
    closeMeta.shapes = shapeManger.createTwoLines(with: closeMeta, shapeToCreate: .exit) // creates the 'x' layer
    closeMeta.shapes?.forEach({ self.view.layer.addSublayer($0) })
  }
  
  
  @objc private func onExitTap(){
    dismiss(animated: true, completion: nil)
  }
}


extension MusicPreviewViewController: PlaybackDeckViewDelegate {
  func onPlaybackTap(withItem item: PlaybackDeckView.Item) {
    print(item)
    switch item {
    case .playback:
      if playbackDeck.isPlaying {
        // stop playback
      } else {
        // start playback
      }
    case .volumeDown:
      break
    case .volumeUp:
      break
    }
  }
}

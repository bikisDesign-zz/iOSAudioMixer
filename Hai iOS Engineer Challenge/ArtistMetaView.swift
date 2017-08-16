//
//  ArtistMetaView.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/16/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit

class ArtistMetaView: UIView {
  
  var result: SearchMeta
  
  lazy var artworkImageView: UIImageView  = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.alpha = 1.0
    self.addSubview(iv)
    return iv
  }()
  
  private lazy var trackLabel: UILabel = {
    let label = UILabel()
    label.font = Theme.Fonts.title.font
    label.text = self.result.trackName
    label.textAlignment = .center
    label.textColor = Theme.Colors.darkText.color
    label.backgroundColor = UIColor.clear
    label.numberOfLines = 0
    self.addSubview(label)
    return label
  }()
  
  private lazy var artistLabel: UILabel = {
    let label = UILabel()
    label.font = Theme.Fonts.cellTitle.font
    label.text = self.result.artist
    label.textColor = Theme.Colors.darkText.color
    label.backgroundColor = UIColor.clear
    label.textAlignment = .center
    self.addSubview(label)
    return label
  }()
  
  private lazy var collectionLabel: UILabel = {
    let label = UILabel()
    label.font = Theme.Fonts.cellDetail.font
    label.text = self.result.collectionName
    label.textColor = Theme.Colors.darkText.color
    label.textAlignment = .center
    label.backgroundColor = UIColor.clear
    self.addSubview(label)
    return label
  }()
  
  
  
  init(result: SearchMeta){
    self.result = result
    super.init(frame: CGRect.zero)
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  override func layoutSubviews() {
    let xpadding: CGFloat = 15
    let width = frame.width - xpadding * 2
  
    collectionLabel.frame = CGRect(x: xpadding, y: frame.height - 15,
                                   width: width, height: 15)
    
    artistLabel.frame = CGRect(x: xpadding, y: collectionLabel.frame.origin.y - 25,
                               width: width, height: 20)
    
    trackLabel.frame = CGRect(x: xpadding, y: artistLabel.frame.origin.y - 40,
                              width: width, height: 35)
    
    if result.artworkURL != nil {
      artworkImageView.frame = CGRect(x: frame.width / 2 - 50, y: trackLabel.frame.origin.y - 120,
                                      width: 100, height: 100)
    }
  }
}

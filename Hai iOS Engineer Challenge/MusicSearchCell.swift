//
//  MusicSearchCell.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SwiftEssentials

class TrackTableViewCell: UITableViewCell, ReusableView {
  private lazy var trackLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = Theme.Colors.darkText.color
    self.addSubview(label)
    return label
  }()
  
  private lazy var collectionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = Theme.Colors.lightText.color
    self.addSubview(label)
    return label
  }()
  
  private var line: CAShapeLayer?
  
  
  override func layoutSubviews() {
    trackLabel.frame = CGRect(x: 25, y: 0,
                              width: frame.width - 50, height: frame.height / 2)
    
    collectionLabel.frame = CGRect(x: 25, y: frame.height / 2,
                              width: frame.width - 50, height: frame.height / 2)
    addBottomLine()
  }
  
  
  func set(withViewModel data: SearchResultItem){
    trackLabel.text = data.artist
    collectionLabel.text = data.trackName
    backgroundColor = Theme.Colors.tertiaryBackground.color
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    trackLabel.textColor = selected ? Theme.Colors.darkText.color : Theme.Colors.lightText.color
    collectionLabel.textColor = trackLabel.textColor
    super.setSelected(selected, animated: animated)
  }
  
  func addBottomLine(){
    if line != nil {
      line?.removeFromSuperlayer()
      line = nil
    }
    
    line = CAShapeLayer()
    line?.strokeColor = Theme.Colors.lightText.color.cgColor
    line?.lineWidth = 1.0
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: frame.height))
    path.addLine(to: CGPoint(x: frame.width, y: frame.height))
    line?.path = path.cgPath
    layer.addSublayer(line!)
  }
}

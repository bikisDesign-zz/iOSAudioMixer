//
//  ResultsMetaTableViewCell.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SwiftEssentials

class ResultsMetaTableViewCell: UITableViewCell, ReusableView {
  
  private lazy var titleLabel: UILabel = self.labelFactory(isTitle: true)
  
  private lazy var subtitleLabel: UILabel = self.labelFactory(isTitle: false)

  private func labelFactory(isTitle: Bool) -> UILabel {
    let label = UILabel()
    if isTitle {
      label.textColor = Theme.Colors.darkText.color
      label.font = Theme.Fonts.cellTitle.font
    } else {
      label.textColor = Theme.Colors.lightText.color
      label.font = Theme.Fonts.cellDetail.font
    }
    self.addSubview(label)
    return label
  }
  
  override func layoutSubviews() {
    titleLabel.frame = CGRect(x: 25, y: 5,
                              width: frame.width - 50, height: frame.height / 2 - 5)
    
    subtitleLabel.frame = CGRect(x: 25, y: frame.height / 2,
                              width: frame.width - 50, height: frame.height / 2 - 5)
  }
  
  
  func set(title: String, subtitle: String){
    titleLabel.text = title
    subtitleLabel.text = subtitle
    backgroundColor = Theme.Colors.primaryBackground.color
  }
}

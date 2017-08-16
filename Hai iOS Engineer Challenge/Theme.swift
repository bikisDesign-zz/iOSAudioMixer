//
//  Theme.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SVNBootstraper

struct Theme {
  
  enum Colors {
    case primaryBackground
    case secondaryBackground
    case tertiaryBackground
    case darkText
    case lightText
    
    
    var color: UIColor {
      switch self {
      case .lightText:
        return UIColor(r: 240, g: 244, b: 245)
      case .primaryBackground:
        return UIColor(r: 224, g: 251, b: 252)
      case .secondaryBackground:
        return UIColor(r: 194, g: 223, b: 227)
      case .tertiaryBackground:
        return UIColor(r: 157, g: 180, b: 192)
      case .darkText:
        return UIColor(r: 15, g: 76, b: 92)
      }
    }
  }
  
  
  enum Fonts {
    case title
    case subtitle
    case cellTitle
    case cellDetail
    
    var font: UIFont {
      switch self {
      case .title:
        return UIFont(name: CustomFont.titlliumReg, size: 22)!
      case .subtitle:
        return UIFont(name: CustomFont.robotoMed, size: 16)!
      case .cellTitle:
        return UIFont(name: CustomFont.titlliumReg, size: 16)!
      case .cellDetail:
        return UIFont(name: CustomFont.robotoMed, size: 12)!
      }
    }
  }
  
  
  enum CellHeight { // the height of a cell based on device
    case large
    case medium
    case small
    
    var forDevice: CGFloat {
      switch self {
      case .large:
        if UIDevice.isSmallIphone() {
          return 50
        }
        return 75
      case .medium:
        if UIDevice.isSmallIphone() {
          return 40
        }
        return 65
      case .small:
        if UIDevice.isSmallIphone() {
          return 30
        }
        return 50
      }
    }
  }
}


// Fonts by their name
private struct CustomFont {
  static let robotoMed: String =  "Roboto-Medium"
  static let robotoThin: String = "Roboto-Thin"
  static let titlliumLight: String = "TitilliumWeb-ExtraLight"
  static let titlliumReg: String = "TitilliumWeb-Regular"
}

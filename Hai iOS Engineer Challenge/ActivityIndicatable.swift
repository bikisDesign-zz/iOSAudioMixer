//
//  ActivityIndicatable.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/16/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit

protocol ActivityIndicatable: class {
  var activityIndicator: ActivityIndicator? { get set }
}


extension ActivityIndicatable where Self: UIViewController {
  func showActivityIndicator(inRect rect: CGRect) {
    activityIndicator = ActivityIndicator()
    activityIndicator?.frame = rect
    DispatchQueue.main.async {
      self.view.addSubview(self.activityIndicator!)
      self.activityIndicator?.animate(isPresenting: true, completion: nil)
    }
  }
  
  
  func hideActivityIndicator() {
    DispatchQueue.main.async {
      self.activityIndicator?.animate(isPresenting: false, completion: { (isFinished) in
        if isFinished {
          self.activityIndicator?.removeFromSuperview()
          self.activityIndicator = nil
        }
      })
    }
  }
}


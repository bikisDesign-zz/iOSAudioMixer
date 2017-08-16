//
//  ActivityIndicatorView.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/16/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit

/// an overlay and activity indicator 
class ActivityIndicator: UIView {
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let ai = UIActivityIndicatorView()
    ai.activityIndicatorViewStyle = .whiteLarge
    ai.color = Theme.Colors.secondaryBackground.color
    ai.startAnimating()
    return ai
  }()
  lazy var container: UIView = {
    let aiContainer = UIView()
    aiContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    aiContainer.layer.borderColor = UIColor.white.cgColor
    aiContainer.layer.borderWidth = 2
    aiContainer.layer.masksToBounds = true
    return aiContainer
  }()
  
  init(){
    super.init(frame: CGRect.zero)
    backgroundColor = UIColor.black
    alpha = 0.0
    addSubview(container)
    container.addSubview(activityIndicator)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  func animate(isPresenting:Bool, completion: ((Bool) -> Void)?){
    UIView.animate(withDuration: 0.25, animations: {
      self.alpha = isPresenting ? 0.35 : 0.0
    }, completion: completion)
  }
  
  override func layoutSubviews() {
    container.frame = CGRect(x: frame.width / 2 - 80 / 2, y: frame.height / 2 - 80 / 2,
                             width: 80, height: 80)
    
    container.layer.cornerRadius = 15
    
    activityIndicator.frame =  CGRect(x: container.frame.width / 2 - 40 / 2, y: container.frame.height / 2 - 40 / 2,
                                      width:40, height: 40)
  }
}


//
//  ApplicationCoordinator.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import SVNBootstraper
import UIKit

final class ApplicationCoordinator:  Coordinator<UINavigationController>, Dependable {
  
  var dependencies: AppDependency?
  
  override init(rootViewController: UINavigationController? = nil) {
    let nc: UINavigationController = rootViewController ?? UINavigationController()
    super.init(rootViewController: nc)
    
    nc.setNavigationBarHidden(true, animated: false)
  }
  
  
  
  override func start(with completion: @escaping (Coordinator<UINavigationController>) -> Void) {
    
    dependencies = AppDependency()
    presentMenu()
    super.start(with: completion)
  }
  
  
  private func presentMenu(){
    rootViewController.show(MusicSearchViewController(), sender: self)
  }
}

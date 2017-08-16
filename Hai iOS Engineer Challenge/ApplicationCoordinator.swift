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
    
    dependencies = AppDependency(requestManagerDelegate: self)
   let musicSearchVC = MusicSearchViewController()
    musicSearchVC.delegate = self
    rootViewController.show(musicSearchVC, sender: self)
    super.start(with: completion)
  }
}


extension ApplicationCoordinator: MusicSearchViewControllerDelegate {
  func performSearch(with text: String) {
    dependencies?.requestManager.search(for: text)
  }
  
  func pushToPreview(withData: SearchResult) {
    let vc = 
  }
}


extension ApplicationCoordinator: AppleMusicRequestManagerDelegate {
  func requestManager(returned results: SearchResults) {
    let vc = rootViewController.viewControllers.first as! MusicSearchViewController
    vc.dataSource.results = results
    vc.tableView.reloadData()
  }
}

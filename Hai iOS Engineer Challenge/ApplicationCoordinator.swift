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
  
  var dependencies: AppDependency? // in larger applications this can be passed around so that each coordinator has direct access to the app's dependencies
  
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
  
  
  func pushToPreview(withData data: SearchMeta) {
    let vc = MusicPreviewViewController(result: data)
    rootViewController.viewControllers.first?.present(vc, animated: true, completion: {
      
      if let track = data.previewURL,
        let url = URL(string: track) {
        self.dependencies?.requestManager.downloadFile(url: url, callback: { (trackData) in
          
          DispatchQueue.main.async {
            
            guard let downloadedTrack = trackData else {
              vc.hideActivityIndicator()
              vc.show(alertWithType: Alerts.issueDownloadingTrack, withCompletionHandler: nil)
              return
            }
            
            vc.downloadedTrack = downloadedTrack
          }
        })
      }
      
      guard let artwork = data.artworkURL else { return } // if there isn't artwork then leave it blank
      guard let url = URL(string: artwork) else { return }
      
      self.dependencies?.requestManager.downloadFile(url: url, callback: { (imageData) in
        
        DispatchQueue.main.async {
          
          guard let data = imageData else { // error with download
            if vc.downloadedTrack != nil {
              vc.hideActivityIndicator()
            }
            vc.show(alertWithType: Alerts.issueDownloadingImage, withCompletionHandler: nil)
            return }
          
          vc.downloadedImage = UIImage(data: data)
        }
      })
    })
  }
}


extension ApplicationCoordinator: AppleMusicRequestManagerDelegate {
  func requestManager(returned results: SearchResults) {
    let vc = rootViewController.viewControllers.first as! MusicSearchViewController
    vc.dataSource.results = results
    vc.tableView.reloadData()
  }
}

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
  
  func pushToPreview(withData data: SearchMeta) {
  
    let vc = MusicPreviewViewController(result: data)
    rootViewController.viewControllers.first?.present(vc, animated: true, completion: {
      
      guard let artwork = data.artworkURL else { return } // if there isn't artwork then leave it blank
      guard let url = URL(string: artwork) else { return }
      
      self.downloadImage(url: url, callback: { (imageData) in
        guard let data = imageData else {
          // alert user
          return }
          DispatchQueue.main.async {
            vc.artistPreview.artworkImageView.image = UIImage(data: data)
        }
      })
    })
  }
  
  
  
  private func downloadImage(url: URL, callback: @escaping ((Data?) -> Void)) {
    print("Download Started")
    getDataFromUrl(url: url) { (data, response, error)  in
      guard let data = data, error == nil else {
        callback(nil)
        return }
      print(response?.suggestedFilename ?? url.lastPathComponent)
      print("Download Finished")
      callback(data)
    }
  }
  
  private func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      completion(data, response, error)
      }.resume()
  }
}


extension ApplicationCoordinator: AppleMusicRequestManagerDelegate {
  func requestManager(returned results: SearchResults) {
    let vc = rootViewController.viewControllers.first as! MusicSearchViewController
    vc.dataSource.results = results
    vc.tableView.reloadData()
  }
}

//
//  AppleMusicRequestManager.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: Any?]

protocol AppleMusicRequestManagerDelegate: class {
  func requestManager(returned results: SearchResults)
}

class AppleMusicRequestManager: NSObject {
  private static let appleApiSearchTerm: String = "https://itunes.apple.com/search?term"
  
  weak var delegate: AppleMusicRequestManagerDelegate?
  
  init(delegate: AppleMusicRequestManagerDelegate) {
    super.init()
    self.delegate = delegate
  }
  
  func search(for text: String){
    let params = text.components(separatedBy: " ")
    
    let fullSearchURL = AppleMusicRequestManager.appleApiSearchTerm.appending(params.reduce("=", { $0 == "=" ? "\($0)\($1)" : "\($0)+\($1)" })) // parse the text to create a valid url
    
    guard let url = URL(string: fullSearchURL) else { return }
    Alamofire.request(url).responseJSON { (response) in
      if response.error != nil {
        print(response.error!.localizedDescription)
      }
      
      guard let json = response.result.value as? JSON else { return }
      var results = SearchResults()
      json.forEach({
        if let child = $0.value as? Array<Any?> {
          child.forEach({
            if let node = $0 as? JSON {
              if let result = SearchMeta(json: node) {
                results.append(result)
              }
            }
          })
        }
      })
      
      self.delegate?.requestManager(returned: results)
    }
  }
}

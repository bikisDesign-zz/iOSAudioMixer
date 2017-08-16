//
//  Dependencies.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import Foundation

/// The app's dependencies 
class AppDependency: AppleMusicRequestable {
  
  var requestManager: AppleMusicRequestManager
  
  init(requestManagerDelegate: AppleMusicRequestManagerDelegate){
    self.requestManager = AppleMusicRequestManager(delegate: requestManagerDelegate)
  }
}

/// The dependencies to be passed around
protocol Dependable: class {
  var dependencies: AppDependency? { get set }
}

protocol AppleMusicRequestable: class {
  var requestManager: AppleMusicRequestManager { get set }
}

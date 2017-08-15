//
//  Dependencies.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import Foundation

struct AppDependency {
  init(){
  }
}


protocol Dependable: class {
  var dependencies: AppDependency? { get set }
}

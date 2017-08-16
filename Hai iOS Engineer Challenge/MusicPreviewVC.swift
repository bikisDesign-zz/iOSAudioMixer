//
//  MusicPreviewVC.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SVNBootstraper

class MusicPreviewViewController: CoordinatableViewController {
  
  var result: SearchMeta
  
  lazy var artistPreview: ArtistMetaView = {
    let preview = ArtistMetaView(result: self.result)
    self.view.addSubview(preview)
    return preview
  }()
  
   init(result: SearchMeta){
    self.result = result
    super.init()
  }
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  override func viewDidLayoutSubviews() {
    artistPreview.frame = CGRect(x: 0, y: view.frame.height / 4,
                                 width: view.frame.width, height: view.frame.height / 2)
  }
}

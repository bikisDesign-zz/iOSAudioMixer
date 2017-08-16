//
//  Alerts.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/16/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import Foundation
import SVNBootstraper

enum Alerts: SVNAlert {
  case errorWithPlayback
  case issueDownloadingImage
  case issueDownloadingTrack
  case issueProcessingRequest
  
  var title: String {
    switch self {
    case .errorWithPlayback:
      return "There was an issue with the playback file"
    case .issueDownloadingImage:
      return "There was an issue downloading the preview image"
    case .issueProcessingRequest:
      return "There was an issue processing your search request"
    case .issueDownloadingTrack:
      return "There was an issue downloading the preview track"
    }
  }
  
  var message: String {
    return "please try again"
  }
}

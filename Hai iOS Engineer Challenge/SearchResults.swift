//
//  MusicSearchViewModel.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import Foundation

typealias SearchResults = [SearchMeta]

protocol SearchResult {
  var artist: String { get set }
  var collectionName: String? { get set }
  var trackName: String? { get set }
  var artworkURL: String? { get set }
  var previewURL: String? { get set }
}


struct ReturnParams {
  static let artistName: String = "artistName"
  static let collectionName: String = "collectionName"
  static let trackName: String = "trackName"
  static let artworkURL: String = "artworkUrl100"
  static let previewURL: String = "previewUrl"
}


struct SearchMeta: SearchResult {
  var artist: String
  var collectionName: String?
  var trackName: String?
  var artworkURL: String?
  var previewURL: String?
  
  
  init?(json: JSON){
    if let artistName = json[ReturnParams.artistName] as? String {
      artist = artistName
    } else {
      return nil
    }
    
    collectionName = json[ReturnParams.collectionName] as? String
    trackName = json[ReturnParams.trackName] as? String
    artworkURL = json[ReturnParams.artworkURL] as? String
    previewURL = json[ReturnParams.previewURL] as? String
  }
}

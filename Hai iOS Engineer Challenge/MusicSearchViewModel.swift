//
//  MusicSearchViewModel.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import Foundation


protocol SearchResults {
  var items: [SearchResultItem] { get set }
}

protocol SearchResultItem {
  var artist: String { get set }
  var collectionName: String { get set }
  var trackName: String { get set }
  var artworkURL: String? { get set }
  var previewURL: String? { get set }
}

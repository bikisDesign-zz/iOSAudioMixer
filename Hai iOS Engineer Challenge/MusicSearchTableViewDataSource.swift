//
//  MusicSearchTableViewDataSource.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SVNBootstraper

struct MusicSearchCellDataSource: SearchResultItem {
  var artist: String
  var trackName: String
  var collectionName: String
  var previewURL: String?
  var artworkURL: String?
}


class MusicSearchTableViewDataSource: NSObject, SearchResults {
  var items: [SearchResultItem]
  
  init(items: [SearchResultItem]) {
    self.items = items
    super.init()
  }
}


extension MusicSearchTableViewDataSource: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    cell.set(withViewModel: items[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
}

//
//  MusicSearchDataSource.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import SwiftEssentials
import UIKit

/// The viewModel for the MusicSearch tableview
class SearchResultsDataSource: NSObject, UITableViewDataSource {
  
  lazy var results: SearchResults = SearchResults()
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ResultsMetaTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    let subtitle = results[indexPath.row].trackName ?? results[indexPath.row].collectionName
    cell.set(title: results[indexPath.row].artist, subtitle: subtitle ?? "")
    return cell
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return results.count
  }
}

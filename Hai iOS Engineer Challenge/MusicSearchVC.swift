//
//  MusicSearchVC.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SVNBootstraper

final class MusicSearchViewController: CoordinatableViewController {
  
  var dataSource: MusicSearchTableViewDataSource?
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.delegate = self
    tv.dataSource = self.dataSource
    tv.register(TrackTableViewCell.self)
    tv.backgroundColor = Theme.Colors.secondaryBackground.color
    return tv
  }()
  
  
}


extension MusicSearchViewController: UITableViewDelegate {
  
}

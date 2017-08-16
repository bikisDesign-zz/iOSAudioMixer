//
//  MusicSearchVC.swift
//  Hai iOS Engineer Challenge
//
//  Created by Aaron Dean Bikis on 8/15/17.
//  Copyright © 2017 bikisDesign. All rights reserved.
//

import UIKit
import SVNBootstraper

protocol MusicSearchViewControllerDelegate: class {
  func performSearch(with text: String)
  func pushToPreview(withData data: SearchMeta)
}

/// The viewController to present results from a search and to search on
final class MusicSearchViewController: CoordinatableViewController, KeyboardNotifiable {
  
  var delegate: MusicSearchViewControllerDelegate?
  
  lazy var dataSource: SearchResultsDataSource = SearchResultsDataSource()
  
  var isAnimating = false // if a keyboard is currently animating then this will be true
  
  private lazy var searchBar: UISearchBar = {
    let searchbar = UISearchBar()
    searchbar.delegate = self
    searchbar.searchBarStyle = UISearchBarStyle.minimal
    searchbar.backgroundColor = Theme.Colors.secondaryBackground.color
    self.view.addSubview(searchbar)
    return searchbar
  }()
  
  
  lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.delegate = self
    tv.dataSource = self.dataSource
    tv.register(ResultsMetaTableViewCell.self)
    tv.backgroundColor = Theme.Colors.secondaryBackground.color
    self.view.addSubview(tv)
    return tv
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Theme.Colors.secondaryBackground.color
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
    registerForKeyboardNotifications(with: #selector(keyboardWillShowOrHide(_:)))
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let selectedRow = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedRow, animated: true)
    }
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForKeyboardNotifications()
  }
  
  
  override func viewDidLayoutSubviews() {
    guard !isAnimating else { return }
    
    searchBar.frame = CGRect(x: 0, y: 15,
                             width: view.frame.width, height: 55)
    
    let tvy = searchBar.frame.height + searchBar.frame.origin.y
    
    tableView.frame = CGRect(x: 0, y: tvy,
                             width: view.frame.width, height: view.frame.height - tvy)
  }
  
  
  func keyboardWillShowOrHide(_ notification: NSNotification) {
    guard let keyboardEnd = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
      let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
    
    isAnimating = true
    
    if notification.name == NSNotification.Name.UIKeyboardWillShow {
      UIView.animate(withDuration: duration, animations: {
        self.tableView.frame.size.height = keyboardEnd.origin.y - (self.searchBar.frame.origin.y + self.searchBar.frame.height)  //  so that it is above the keyboard with a little padding
      })
    
    } else if notification.name == NSNotification.Name.UIKeyboardWillHide {
      UIView.animate(withDuration: duration, animations: {
        self.tableView.frame.size.height = self.view.frame.height - (self.searchBar.frame.origin.y + self.searchBar.frame.height)
      })
    }
  }
}



extension MusicSearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationController?.setNavigationBarHidden(false, animated: true)
    delegate?.pushToPreview(withData: dataSource.results[indexPath.row])
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Theme.CellHeight.medium.forDevice
  }
}



extension MusicSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    delegate?.performSearch(with: searchText)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.characters.count >= 4 { 
      delegate?.performSearch(with: searchText)
    }
  }
}

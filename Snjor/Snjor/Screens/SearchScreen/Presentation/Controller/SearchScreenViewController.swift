//
//  SearchScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

final class SearchScreenViewController: BaseViewController<SearchScreenRootView> {
  
  let searchController = UISearchController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.automaticallyShowsSearchResultsController = true
    searchController.searchBar.showsScopeBar = true
    navigationItem.hidesSearchBarWhenScrolling = false

    searchController.searchBar.scopeButtonTitles = [
      "Photos",
      "Collections",
      "Users"
    ]
    
    addChildController(photoListViewController(), view: rootView.photoListContainerView)
    setupVisibleContainers()
  }
  
  func photoListViewController() -> UIViewController {
    let factory = PhotoListFactory()
    let controller = factory.makeModule(delegate: self)
    return controller
  }
  
  func pageViewController() -> UIViewController {
    let factory = TopicsPageFactory()
    let controller = factory.makeModule()
    return controller
  }
  
  private func addChildController(_ child: UIViewController, view: UIView) {
    addChild(child)
    view.addSubview(child.view)
    child.view.fillSuperView()
    child.didMove(toParent: self)
  }
  
  private func setupVisibleContainers() {
    rootView.photoListContainerView.isHidden = false
    rootView.topicContainerView.isHidden = true
    rootView.usersContainerView.isHidden = true
  }
}

// MARK: - Extension
extension SearchScreenViewController: PhotoListCollectionViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    print(#function, Self.self)
  }
}

extension SearchScreenViewController: UISearchBarDelegate {
  func searchBar(
    _ searchBar: UISearchBar,
    selectedScopeButtonIndexDidChange selectedScope: Int
  ) {
    switch selectedScope {
    case 0:
      rootView.photoListContainerView.isHidden = false
      rootView.topicContainerView.isHidden = true
      rootView.usersContainerView.isHidden = true
    case 1:
      rootView.photoListContainerView.isHidden = true
      rootView.topicContainerView.isHidden = false
      rootView.usersContainerView.isHidden = true
      print("Collections")
    case 2:
      rootView.photoListContainerView.isHidden = true
      rootView.topicContainerView.isHidden = true
      rootView.usersContainerView.isHidden = false
      print("Users")
    default:
      break
    }
  }
}


extension SearchScreenViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    print(#function)
  }
}

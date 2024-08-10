//
//  SearchScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

final class SearchScreenViewController: BaseViewController<SearchScreenRootView> {
  
  let searchController = UISearchController()
  
  
  private lazy var photosViewController: UIViewController = {
    let factory = PhotoListFactory()
    let controller = factory.makeModule(delegate: self)
    return controller
  }()
  
  private lazy var albumsViewController: UIViewController = {
    let factory = AlbumListFactory()
    let controller = factory.makeModule()
    return controller
  }()
  
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
    
    addChildController(photosViewController, to: rootView.photoListContainerView)
    setupVisibleContainers()
    setupNavigationBarAppearance()
  }
  
  private func setupNavigationBarAppearance() {
    // Установка стиля навигационной панели
    if let navigationBar = navigationController?.navigationBar {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithDefaultBackground()
      navigationBar.standardAppearance = appearance
      navigationBar.scrollEdgeAppearance = appearance
    }
  }
  
  private func addChildController(_ child: UIViewController, to view: UIView) {
    addChild(child)
    view.addSubview(child.view)
    child.view.fillSuperView()
    child.didMove(toParent: self)
  }
  
  private func setupVisibleContainers() {
    rootView.photoListContainerView.isHidden = false
    rootView.albumListContainerView.isHidden = true
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
      rootView.albumListContainerView.isHidden = true
      rootView.usersContainerView.isHidden = true
    case 1:
      rootView.photoListContainerView.isHidden = true
      rootView.albumListContainerView.isHidden = false
      rootView.usersContainerView.isHidden = true
      if albumsViewController.parent == nil {
        addChildController(albumsViewController, to: rootView.albumListContainerView)
      }
    case 2:
      rootView.photoListContainerView.isHidden = true
      rootView.albumListContainerView.isHidden = true
      rootView.usersContainerView.isHidden = false
      //      addChildController(
      //        albumListViewController(),
      //        view: rootView.usersContainerView
      //      )
    default:
      break
    }
  }
}


extension SearchScreenViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    //    print(#function)
  }
}

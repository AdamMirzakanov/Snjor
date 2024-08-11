//
//  SearchScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine
import Photos

final class SearchScreenViewController: BaseViewController<SearchScreenRootView> {
  
  // MARK: - Delegate
  private(set) weak var delegate: (any PhotoListCollectionViewControllerDelegate)?
  
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var downloadService = DownloadService()
  private(set) var viewModel: any SearchScreenViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!
  
  let searchController = UISearchController()
  
  // MARK: - Initializers
  init(
    viewModel: any SearchScreenViewModelProtocol,
    delegate: any PhotoListCollectionViewControllerDelegate
  ) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.viewDidLoad()
    stateController()
    setupDataSource()
    configureDownloadSession()
    
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
      "Collections"
    ]
    
    setupVisibleContainers()
  }
  
  private func setupVisibleContainers() {
    rootView.albumsCollectionView.removeFromSuperview()
  }
  
  // MARK: - Private Methods
  private func setupDataSource() {
    viewModel.createPhotosDataSource(
      for: rootView.photoListCollectionView,
      delegate: self
    )
    viewModel.createAlbumsDataSource(
      for: rootView.albumsCollectionView
    )
  }

  private func configureDownloadSession() {
    downloadService.configureSession(
      delegate: self,
      id: Self.sessionID
    )
  }

  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          viewModel.applyPhotosSnapshot()
          viewModel.applyAlbumsSnapshot()
        case .loading: break
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
}

// MARK: - Extension


extension SearchScreenViewController: UISearchBarDelegate {
  func searchBar(
    _ searchBar: UISearchBar,
    selectedScopeButtonIndexDidChange selectedScope: Int
  ) {
    switch selectedScope {
    case .zero:
      rootView.albumsCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.photoListCollectionView)
      rootView.photoListCollectionView.fillSuperView()
    default:
      rootView.photoListCollectionView.removeFromSuperview()
      rootView.addSubview(rootView.albumsCollectionView)
      rootView.albumsCollectionView.fillSuperView()
    }
  }
}

extension SearchScreenViewController: PhotoListCollectionViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    print(#function, Self.self)
  }
}

extension SearchScreenViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    //    print(#function)
  }
}

extension SearchScreenViewController: MessageDisplayable { }

extension SearchScreenViewController: URLSessionDownloadDelegate {
  // MARK: - URL Session Download Delegate
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {
    guard let sourceURL = downloadTask.originalRequest?.url else { return }
    let destinationURL = localFilePath(for: sourceURL)
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      saveImageToGallery(at: destinationURL)
    } catch let error {
      self.presentAlert(
        message: error.localizedDescription,
        title: AppLocalized.error
      )
    }
  }

  // MARK: - Private Methods
  private func saveImageToGallery(at url: URL) {
    PHPhotoLibrary.requestAuthorization { status in
      guard status == .authorized else { return }
      PHPhotoLibrary.shared().performChanges {
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      } completionHandler: { success, error in
        if success {
          self.hideSpinner()
          print(#function, "🇧🇷 Successfully saved image to gallery.")
        } else if let error = error {
          self.presentAlert(
            message: "\(error.localizedDescription)",
            title: AppLocalized.error
          )
        }
      }
    }
  }

  private func localFilePath(for url: URL) -> URL {
    let component = url.lastPathComponent
    var destinationURL = documentsPath.appendingPathComponent(component)
    if destinationURL.pathExtension.isEmpty {
      destinationURL = destinationURL.appendingPathExtension(.jpegExt)
    }
    return destinationURL
  }
  
  private func hideSpinner() {
    DispatchQueue.main.async {
      self.rootView.photoListCollectionView.visibleCells
        .compactMap { $0 as? PhotoListCell }
        .forEach { cell in
          cell.mainView.spinner.stopAnimating()
          cell.mainView.spinner.isHidden = true
          cell.mainView.downloadButton.isHidden = false
        }
    }
  }
}

extension SearchScreenViewController: PhotoCellDelegate {
  func downloadTapped(_ cell: PhotoListCell) {
    if let indexPath = rootView.photoListCollectionView.indexPath(for: cell) {
      let photo = viewModel.getPhoto(at: indexPath.item)
      downloadService.startDownload(photo, sessionID: Self.sessionID)
    }
  }
}

extension SearchScreenViewController: SessionIdentifiable { }

extension SearchScreenViewController: CascadeLayoutDelegate {
  func cascadeLayout(
    _ layout: any CascadeLayoutConformable,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = viewModel.getPhoto(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
//extension SearchScreenViewController {
//  // MARK: - UIScrollViewDelegate
//  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
//    return .bottom
//  }
//
//  override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//    if let tabBar = tabBarController as? MainTabBarController {
//      tabBar.hideCustomTabBar()
//    }
//  }
//
//  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//    if let tabBar = tabBarController as? MainTabBarController {
//      tabBar.showCustomTabBar()
//    }
//  }
//
//  override func scrollViewDidEndDragging(
//    _ scrollView: UIScrollView,
//    willDecelerate decelerate: Bool
//  ) {
//    if !decelerate {
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//        if let tabBar = self.tabBarController as? MainTabBarController {
//          tabBar.showCustomTabBar()
//        }
//      }
//    }
//  }
//}

//extension SearchScreenViewController {
//  override func collectionView(
//    _ collectionView: UICollectionView,
//    didSelectItemAt indexPath: IndexPath
//  ) {
//    guard let delegate = delegate else { return }
//    let photo = viewModel.getPhoto(at: indexPath.item)
//    delegate.didSelect(photo)
//  }
//}

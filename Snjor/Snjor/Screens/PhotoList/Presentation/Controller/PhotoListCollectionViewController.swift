////
////  PhotoListCollectionViewController.swift
////  Snjor
////
////  Created by Адам on 16.06.2024.
////
//
//import UIKit
//import Combine
//
protocol PhotosCollectionViewControllerDelegate: AnyObject {
  func didSelect(_ photo: Photo)
}
//
//final class PhotoListCollectionViewController: UICollectionViewController {
//
//  // MARK: - Delegate
//  private(set) weak var delegate: (any PhotosCollectionViewControllerDelegate)?
//  
//  // MARK: - Private Properties
//  private let searchController: UISearchController = {
//    $0.obscuresBackgroundDuringPresentation = false
//    $0.automaticallyShowsSearchResultsController = true
//    $0.searchBar.placeholder = "Search photos, collections, users"
//    return $0
//  }(UISearchController())
//  
//  private var cancellable = Set<AnyCancellable>()
//  private(set) var downloadService = DownloadService()
//  private(set) var viewModel: any PhotosViewModelProtocol
//  private(set) var documentsPath = FileManager.default.urls(
//    for: .documentDirectory,
//    in: .userDomainMask
//  ).first!
//
//  // MARK: - Initializers
//  init(
//    viewModel: any PhotoListViewModelProtocol,
//    delegate: any PhotoListCollectionViewControllerDelegate,
//    layout: UICollectionViewLayout
//  ) {
//    self.viewModel = viewModel
//    self.delegate = delegate
//    super.init(collectionViewLayout: layout)
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  // MARK: - View Lifecycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    viewModel.viewDidLoad()
//    stateController()
//    setupDataSource()
//    configureDownloadSession()
//  }
//
//  // MARK: - Private Methods
//  private func setupDataSource() {
//    viewModel.createPhotosDataSource(
//      for: collectionView,
//      delegate: self
//    )
//  }
//
//  private func configureDownloadSession() {
//    downloadService.configureSession(
//      delegate: self,
//      id: Self.sessionID
//    )
//  }
//
//  private func stateController() {
//    viewModel
//      .state
//      .receive(on: DispatchQueue.main)
//      .sink { [weak self] state in
//        guard let self = self else { return }
//        switch state {
//        case .success:
//          viewModel.applyPhotosSnapshot()
//        case .loading: break
//        case .fail(error: let error):
//          self.presentAlert(message: error, title: AppLocalized.error)
//        }
//      }
//      .store(in: &cancellable)
//  }
//}

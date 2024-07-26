////
////  TopicsPhotosCollectionViewController.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 22.07.2024.
////
//
//import UIKit
//import Combine
//
//class PhotosCollectionViewController: UICollectionViewController {
//  
//  var topicID: String?
//  var pageIndex: Int?
//  var photos: [TopicPhoto] = []
//  private let itemController = ItemController()
//  private let query: [String: String] = [:]
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setupCollectionView()
//    sendRequest()
//    
//  }
//  
//  init() {
//    let layout = UICollectionViewFlowLayout()
//    super.init(collectionViewLayout: layout)
//  }
//  
//  required init?(coder: NSCoder) {
//    super.init(coder: coder)
//  }
//  
//  private func setupCollectionView() {
//    collectionView.register(
//      PhotosCollectionViewCell.self,
//      forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseID
//    )
//  }
//  
//  func sendRequest() {
//    guard let id = topicID else { return }
//    let photosRequest = PhotosAPIRequest(query: query, id: id)
//    itemController.sendRequest(photosRequest) { [weak self] result in
//      guard let strongSelf = self else { return }
//      DispatchQueue.main.async {
//        switch result {
//        case .success(let photos):
//          strongSelf.photos = photos
//          strongSelf.collectionView.reloadData()
//        case .failure(let error):
//          print(#function, "Ошибка:", error, "/photos")
//        }
//      }
//    }
//  }
//  
//  // MARK: - UICollectionViewDataSource
//  override func numberOfSections(
//    in collectionView: UICollectionView
//  ) -> Int {
//    return 1
//  }
//  
//  
//  override func collectionView(
//    _ collectionView: UICollectionView,
//    numberOfItemsInSection section: Int
//  ) -> Int {
//    return photos.count
//  }
//  
//  override func collectionView(
//    _ collectionView: UICollectionView,
//    cellForItemAt indexPath: IndexPath
//  ) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(
//      withReuseIdentifier: PhotosCollectionViewCell.reuseID,
//      for: indexPath
//    )
//    guard let photoCell = cell as? PhotosCollectionViewCell else { return cell }
//    let photo = photos[indexPath.item]
//    photoCell.configure(with: photo)
//    return photoCell
//  }
//  
//  // MARK: - UICollectionViewDelegate
//  
//}
//
//
//class PhotosCollectionViewCell: UICollectionViewCell, Reusable {
//  // MARK: - View
//  let photoView: PhotoCellPhotoView = {
//    $0.layer.cornerRadius = 10
//    $0.clipsToBounds = true
//    return $0
//  }(PhotoCellPhotoView())
//  
//  // MARK: - Initializers
//   override init(frame: CGRect) {
//     super.init(frame: frame)
//     setupPhotoView()
//   }
//
//   required init?(coder: NSCoder) {
//     fatalError("init(coder:) has not been implemented")
//   }
//
//   // MARK: - Override Methods
//   override func prepareForReuse() {
//     super.prepareForReuse()
//     photoView.prepareForReuse()
//   }
//
//   // MARK: - Setup Data
//   func configure(with photo: TopicPhoto) {
//     let url = photo.urls[.regular]
//     photoView.configure(url: url)
//   }
//
//   // MARK: - Setup Views
//   private func setupPhotoView() {
//     contentView.addSubview(photoView)
//     photoView.fillSuperView()
//   }
//}

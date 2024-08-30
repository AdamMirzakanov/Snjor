////
////  SearchResultPhotoCell.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 22.08.2024.
////
//
//import UIKit
//
//protocol SearchResultPhotoCellDelegate: AnyObject {
//  func downloadTapped(_ cell: SearchResultPhotoCell)
//}
//
//final class SearchResultPhotoCell: UICollectionViewCell {
//  // MARK: - Delegate
//  weak var delegate: (any SearchResultPhotoCellDelegate)?
//
//  // MARK: - Main View
//  let mainView: SearchResultPhotoCellMainView = {
//    return $0
//  }(SearchResultPhotoCellMainView())
//
//  // MARK: - Initializers
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    setupMainView()
//    mainView.delegate = self
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  // MARK: - Override Methods
//  override func prepareForReuse() {
//    super.prepareForReuse()
//    mainView.prepareForReuse()
//  }
//
//  // MARK: - Setup Data
//  func configure(viewModelItem: SearchResultPhotosViewModelItem) {
//    let photo = viewModelItem.photo
//    let photoURL = viewModelItem.photoURL
//    mainView.configure(with: photo, url: photoURL)
//  }
//
//  // MARK: - Setup Views
//  private func setupMainView() {
//    contentView.addSubview(mainView)
//    mainView.fillSuperView()
//  }
//}
//

//
//  ThirdCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

class ThirdCell: UICollectionViewCell {
  // MARK: Internal Properties
  var userAlbumsSections: [UserAlbumsSection] = []
  var userAlbumsDataSource: UserAlbumsDataSource?
  var userAlbumsViewModel: (any ContentManagingProtocol<Album>)?
  
  // MARK: Private Properties
  private let layoutFactory = UserAlbumsLayoutFactory()
  
  // MARK: Views
  private let userAlbumsCollectionView: UserAlbumsCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserAlbumsCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupLayout()
    createAlbumsDataSource(for: userAlbumsCollectionView)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Album>) {
    self.userAlbumsViewModel = viewModel
    applyAlbumsSnapshot()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    contentView.addSubview(userAlbumsCollectionView)
    userAlbumsCollectionView.frame = contentView.bounds
  }
  
  private func setupLayout() {
    let layout = layoutFactory.createAlbumsLayout()
    userAlbumsCollectionView.collectionViewLayout = layout
  }
}

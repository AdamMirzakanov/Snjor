//
//  ThirdCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class ThirdCell: BaseColletionViewCell<ThirdCellRootView> {
  // MARK: Internal Properties
  var userAlbumsSections: [UserAlbumsSection] = []
  var userAlbumsDataSource: UserAlbumsDataSource?
  var userAlbumsViewModel: (any ContentManagingProtocol<Album>)?
  weak var delegate: (any ThirdCellDelegate)?
  
  // MARK: Private Properties
  private let layoutFactory = UserAlbumsLayoutFactory()
  
  // MARK: Initializers
  override func initCell() {
    super.initCell()
    setupLayout()
    createAlbumsDataSource(for: rootView.userAlbumsCollectionView)
    setupCollectionViewDelegate()
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Album>) {
    self.userAlbumsViewModel = viewModel
    applyAlbumsSnapshot()
  }
  
  private func setupLayout() {
    let layout = layoutFactory.createAlbumsLayout()
    rootView.userAlbumsCollectionView.collectionViewLayout = layout
    rootView.userAlbumsCollectionView.frame = contentView.bounds
  }
  
  private func setupCollectionViewDelegate() {
    rootView.userAlbumsCollectionView.userAlbumsDelegate = self
  }
}

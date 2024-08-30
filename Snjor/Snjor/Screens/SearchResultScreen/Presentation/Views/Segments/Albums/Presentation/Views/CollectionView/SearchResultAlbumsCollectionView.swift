////
////  SearchResultAlbumsCollectionView.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 29.08.2024.
////
//
//import UIKit
//
//final class SearchResultAlbumsCollectionView: UICollectionView {
//  // MARK: - Private Properties
//  private let flowlayout = UICollectionViewFlowLayout()
//  
//  // MARK: - Initializers
//  init() {
//    super.init(frame: .zero, collectionViewLayout: flowlayout)
//    configureLayout()
//    cellRegister()
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  // MARK: - Private Methods
//  private func configureLayout() {
//    flowlayout.scrollDirection = .vertical
//    backgroundColor = .clear
//  }
//  
//  private func cellRegister() {
//    register(
//      SearchResultAlbumCell.self,
//      forCellWithReuseIdentifier: SearchResultAlbumCell.reuseID
//    )
//  }
//}
//
//

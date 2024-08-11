////
////  PhotoList + UICollectionViewDelegate.swift
////  Snjor
////
////  Created by Адам on 21.06.2024.
////
//
//import UIKit
//
//extension PhotoListCollectionViewController {
//  override func collectionView(
//    _ collectionView: UICollectionView,
//    didSelectItemAt indexPath: IndexPath
//  ) {
//    guard let delegate = delegate else { return }
//    let photo = viewModel.getPhoto(at: indexPath.item)
//    delegate.didSelect(photo)
//  }
//}

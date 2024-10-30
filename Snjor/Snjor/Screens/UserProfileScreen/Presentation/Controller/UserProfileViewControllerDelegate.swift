//
//  UserProfileViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

protocol UserProfileViewControllerDelegate: AnyObject {
  func didSelectUserLikedPhoto(_ photo: Photo)
  func didSelectUserPhoto(_ photo: Photo)
  func didSelectUserAlbum(_ album: Album)
}

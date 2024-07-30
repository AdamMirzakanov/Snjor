//
//  TopicsPageViewController + TopicPhotoListCollectionViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

extension TopicsPageViewController: TopicPhotoListCollectionViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    let photoDetailFactory = PhotoDetailFactory(photo: photo)
    let photoDetailViewController = photoDetailFactory.makeModule()
    navigationController?.pushViewController(
      photoDetailViewController,
      animated: true
    )
  }
}

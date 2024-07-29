//
//  TopicsPage + UICollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension TopicsPageViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let page = viewControllerForTopic(at: indexPath.item) else { return }
        rootView.pageViewController.setViewControllers([page], direction: .forward, animated: true)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            rootView.categoryCollectionView.updateIndicatorPosition(for: cell)
        }
    }

    private func updateIndicatorPositionForVisibleCells() {
        let visibleIndexPaths = rootView.categoryCollectionView.indexPathsForVisibleItems.sorted()
        if let indexPath = visibleIndexPaths.first, let cell = rootView.categoryCollectionView.cellForItem(at: indexPath) {
            rootView.categoryCollectionView.updateIndicatorPosition(for: cell)
        }
    }
}



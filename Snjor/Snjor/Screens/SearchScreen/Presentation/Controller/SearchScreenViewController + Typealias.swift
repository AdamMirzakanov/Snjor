//
//  SearchScreenViewController + Typealias.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

import UIKit

typealias DiscoverDataSource = UICollectionViewDiffableDataSource<DiscoverSection, Photo>
typealias TopicsAndAlbumsDataSource = UICollectionViewDiffableDataSource<TopicsAndAlbumsSection, CollectionsItem>

typealias DiscoverSnapshot = NSDiffableDataSourceSnapshot<DiscoverSection, Photo>
typealias TopicsAndAlbumsSnapshot = NSDiffableDataSourceSnapshot<TopicsAndAlbumsSection, CollectionsItem>

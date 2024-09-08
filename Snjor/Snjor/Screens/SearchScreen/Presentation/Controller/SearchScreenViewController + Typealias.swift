//
//  SearchScreenViewController + Typealias.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

import UIKit

//DataSource
typealias DiscoverDataSource = UICollectionViewDiffableDataSource<DiscoverSection, Photo>
typealias TopicsAndAlbumsDataSource = UICollectionViewDiffableDataSource<TopicsAndAlbumsSection, TopicsAndAlbumsItem>
typealias UsersDataSource = UITableViewDiffableDataSource<UsersSection, User>

//Snapshot
typealias DiscoverSnapshot = NSDiffableDataSourceSnapshot<DiscoverSection, Photo>
typealias TopicsAndAlbumsSnapshot = NSDiffableDataSourceSnapshot<TopicsAndAlbumsSection, TopicsAndAlbumsItem>
typealias UsersSnapshot = NSDiffableDataSourceSnapshot<UsersSection, User>

//
//  SearchResultViewController + Typealias.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

import UIKit

//DataSource
typealias SearchResultPhotosDataSource = UICollectionViewDiffableDataSource<SearchResultPhotosSection, Photo>
typealias SearchResultAlbumsDataSource = UICollectionViewDiffableDataSource<SearchResultAlbumsSection, Album>
typealias SearchResultUsersDataSource = UITableViewDiffableDataSource<SearchResultUsersSection, User>

//Snapshot
typealias SearchResultPhotosSnapshot = NSDiffableDataSourceSnapshot<SearchResultPhotosSection, Photo>
typealias SearchResultAlbumsSnapshot = NSDiffableDataSourceSnapshot<SearchResultAlbumsSection, Album>
typealias SearchResultUsersSnapshot = NSDiffableDataSourceSnapshot<SearchResultUsersSection, User>

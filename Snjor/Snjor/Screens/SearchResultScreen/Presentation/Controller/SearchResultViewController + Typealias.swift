//
//  SearchResultViewController + Typealias.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.09.2024.
//

import UIKit

typealias PhotosDataSource = UICollectionViewDiffableDataSource<SearchResultPhotosSection, Photo>
typealias AlbumsDataSource = UICollectionViewDiffableDataSource<AlbumsSection, Album>

typealias PhotosSnapshot = NSDiffableDataSourceSnapshot<SearchResultPhotosSection, Photo>
typealias AlbumsSnapshot = NSDiffableDataSourceSnapshot<AlbumsSection, Album>

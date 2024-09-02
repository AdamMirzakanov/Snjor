////
////  OldTopicsViewModel.swift
////  Snjor
////
////  Created by Адам Мирзаканов on 23.07.2024.
////
//
//import UIKit
//import Combine
//
//final class OldTopicsViewModel: OldTopicsViewModelProtocol {
//  
//  // MARK: - Internal Properties
//  var topicsCount: Int { topics.count }
//  var state: PassthroughSubject<StateController, Never>
//  
//  // MARK: - Private Properties
//  private let loadUseCase: any LoadTopicsUseCaseProtocol
//  var topics: [Topic] = []
////  private var dataSource: UICollectionViewDiffableDataSource<Section, Topic>?
////  
////  private var snapshot: NSDiffableDataSourceSnapshot<Section, Topic> {
////    var snapshot = NSDiffableDataSourceSnapshot<Section, Topic>()
////    snapshot.appendSections([.main])
////    snapshot.appendItems(topics)
////    return snapshot
////  }
//  
//  // MARK: - Initializers
//  init(
//    state: PassthroughSubject<StateController, Never>,
//    loadUseCase: any LoadTopicsUseCaseProtocol
//  ) {
//    self.state = state
//    self.loadUseCase = loadUseCase
//  }
//
//  // MARK: - Internal Methods
//  func viewDidLoad() {
//    state.send(.loading)
//    Task {
//      await loadTopicsPageUseCase()
//    }
//  }
//  
//  func getTopic(at index: Int) -> Topic {
//    topics[index]
//  }
//  
//  func getTopicsPageViewModelItem(at index: Int) -> ViewModelItem {
//    return makeViewModelItem(at: index)
//  }
//  
////  func createDataSource(
////    for collectionView: UICollectionView
////  ) {
////    dataSource = UICollectionViewDiffableDataSource<Section, Topic>(
////      collectionView: collectionView
////    ) { [weak self] collectionView, indexPath, topicItem in
////      return self?.configureCell(
////        collectionView: collectionView,
////        indexPath: indexPath,
////        topic: topicItem
////      ) ?? UICollectionViewCell()
////    }
////  }
//  
////  func applySnapshot() {
////    guard let dataSource = dataSource else { return }
////    dataSource.apply(
////      snapshot,
////      animatingDifferences: true
////    )
////  }
//
//  // MARK: - Private Methods
//  private func makeViewModelItem(at index: Int) -> OldTopicsViewModelItem {
//    let topic = topics[index]
//    return OldTopicsViewModelItem(topic: topic)
//  }
//  
//  private func loadTopicsPageUseCase() async {
//    let result = await loadUseCase.execute()
//    updateStateUI(with: result)
//  }
//
//  private func updateStateUI(with result: Result<[Topic], Error>) {
//    switch result {
//    case .success(let topics):
//      self.topics.append(contentsOf: topics)
//      state.send(.success)
//      CollectionsItem.topics = self.topics.map { CollectionsItem.topic($0) } 
//    case .failure(let error):
//      state.send(.fail(error: error.localizedDescription))
//    }
//  }
//  
//  private func configureCell(
//    collectionView: UICollectionView,
//    indexPath: IndexPath,
//    topic: Topic
//  ) -> UICollectionViewCell {
//    guard
//      let cell = collectionView.dequeueReusableCell(
//        withReuseIdentifier: PageScreenTopicCell.reuseID,
//        for: indexPath
//      ) as? PageScreenTopicCell
//    else {
//      return UICollectionViewCell()
//    }
//    let viewModelItem = getTopicsPageViewModelItem(at: indexPath.item)
//    cell.configure(viewModelItem: viewModelItem)
//    return cell
//  }
//}
////
////private enum Section: CaseIterable {
////  case main
////}

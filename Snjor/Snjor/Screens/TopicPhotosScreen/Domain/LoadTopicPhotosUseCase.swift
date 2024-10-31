//
//  LoadTopicPhotosUseCase.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

// MARK: - Protocol
/// Протокол, определяющий функциональность для загрузки фотографий отдельно взятого топика.
///
/// Загружаемые фотографии являются:
///   - Фотографиями отдельно взятого топика, отображающиеся в
///   отдельно взятом `PageScreenPhotosViewController` который
///   распологается внутри `PageScreenViewController` в качестве страницы,
///   количество этих страниц равно количеству топиков предоставляемых хостингом.
///
///   - Фотографиями отдельно взятого топика отображающиеся на экране `TopicPhotosViewController`,
///   топики в данном случае - перейдя по которым откроется этот экран, являются ячейками в первой секции
///   коллекционного представления `TopicsAndAlbumsCollectionView`,
///   который распологается в `SearchScreenViewController` в сегменте Topics & Albums
protocol LoadTopicPhotosUseCaseProtocol {
  
  /// Асинхронная функция, выполняющая загрузку фотографий.
  /// - Returns: Возвращает результат типа `Result<[Photo], any Error>`,
  /// содержащий массив объектов `[Photo]` в случае успеха или ошибку в случае неудачи.
  func execute() async -> Result<[Photo], any Error>
}

// MARK: - Struct
struct LoadTopicPhotosUseCase: LoadTopicPhotosUseCaseProtocol {
  
  /// Репозиторий, реализующий протокол `LoadTopicPhotosRepositoryProtocol`,
  /// используемый для загрузки списка фотографий отдельно взятого топика.
  let repository: any LoadTopicPhotosRepositoryProtocol
  let topic: Topic
  
  func execute() async -> Result<[Photo], any Error> {
    do {
      let request = try RequestController.topicPhotosRequest(topic: topic)
      let photos = try await repository.fetchTopicsPhotoList(request: request)
      return .success(photos)
    } catch {
      return .failure(error)
    }
  }
}

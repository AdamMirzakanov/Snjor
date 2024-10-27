//
//  MainImageContainerView.swift
//  Snjor
//
//  Created by Адам on 18.07.2024.
//

import UIKit

fileprivate typealias Const = MainImageContainerViewConst

/// Класс `MainImageContainerView` представляет собой пользовательский `UIView`,
/// отвечающее за отображение изображения с поддержкой загрузки.
class MainImageContainerView: UIView {
  
  // MARK: Internal Properties
  /// Идентификатор текущей фотографии, используемый для отслеживания
  /// загруженного изображения. Позволяет предотвратить обновление изображения в
  /// `mainImageView`, если оно не соответствует текущему идентификатору фотографии.
  var currentPhotoID: String?
  
  /// Экземпляр `imageDownloader` класса `ImageDownloader`, ответственный за
  /// загрузку изображений из сети. Используется для асинхронной загрузки
  /// и обработки изображений перед их отображением в представлении.
  let imageDownloader = ImageDownloader()
  
  let mainImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  /// Метод `configure`, который настраивает изображение для отображения в `mainImageView`.
  ///
  /// - Параметры:
  ///   - `url`: URL-адрес изображения для загрузки.
  ///   - `blurHash`: Опциональная строка, представляющая значение blurHash для
  ///     предварительного отображения размытого изображения перед загрузкой основного.
  ///   - `photoID`: Опциональный идентификатор фотографии, который устанавливается в
  ///     `currentPhotoID` для отслеживания загруженного изображения.
  ///
  /// Метод сначала устанавливает `currentPhotoID`, затем проверяет, предоставлен ли
  /// `blurHash`. Если да, то создается размытие изображения с помощью blurHash,
  /// и запускается загрузка изображения по указанному URL. Если `blurHash` не
  /// предоставлен, запускается загрузка изображения сразу.
  func configure(
    url: URL?,
    blurHash: String? = nil,
    photoID: String? = nil
  ) {
    currentPhotoID = photoID
    let blurSize = Const.blurSize
    if let blurHash = blurHash {
      self.mainImageView.image = UIImage(blurHash: blurHash, size: blurSize)
      self.downloadImage(url, photoID)
    } else {
      downloadImage(url, photoID)
    }
  }
  
  /// Метод `sizedImageURL(from:)`, который принимает URL изображения и возвращает его.
  ///
  /// Этот метод может быть переопределен в подклассах для изменения URL-адреса
  /// изображения, например, для изменения его размера.
  /// В текущей реализации он просто возвращает переданный URL без изменений.
  func sizedImageURL(from url: URL) -> URL {
    return url
  }
  
  // MARK: Private Methods
  private func setupViews() {
    addSubview(mainImageView)
    mainImageView.fillSuperView()
  }
  
  /// Метод `downloadImage`, который инициирует загрузку изображения по указанному URL.
  ///
  /// - Параметры:
  ///   - `url`: URL-адрес изображения для загрузки. Если URL равен `nil`, метод завершает работу.
  ///   - `photoID`: Идентификатор фотографии, используемый для проверки соответствия
  ///     текущего загружаемого изображения.
  ///
  /// Метод преобразует переданный URL с помощью `sizedImageURL(from:)`, а затем
  /// использует экземпляр `imageDownloader` для загрузки изображения. В замыкании
  /// проверяется, что текущий `currentPhotoID` совпадает с загружаемым `downloadPhotoID`,
  /// чтобы избежать обновления устаревшего изображения. Если проверки проходят,
  /// вызывается метод `updateImage` для обновления `mainImageView`.
  private func downloadImage(
    _ url: URL?,
    _ photoID: String?
  ) {
    guard let url = url else { return }
    let photoURL = sizedImageURL(from: url)
    let downloadPhotoID = photoID
    imageDownloader.downloadPhoto(with: photoURL) { [weak self] (image, isCached) in
      guard let self = self,
            self.currentPhotoID == downloadPhotoID
      else { return }
      updateImage(image, isCached)
    }
  }
  
  /// Метод `updateImage`, который обновляет изображение в `mainImageView`
  /// в зависимости от того, было ли изображение загружено из кэша.
  ///
  /// - Параметры:
  ///   - `image`: Загруженное изображение, которое нужно отобразить.
  ///   - `isCached`: Булево значение, указывающее, загружено ли изображение из кэша.
  ///
  /// Если изображение было загружено из кэша (`isCached` равно `true`),
  /// оно устанавливается напрямую в `mainImageView`. В противном случае,
  /// вызывается метод `animateImageView` для анимации перехода между
  /// предыдущим и новым изображением, создавая плавный эффект при его
  /// отображении.
  private func updateImage(_ image: UIImage?, _ isCached: Bool) {
    if isCached {
      mainImageView.image = image
    } else {
      animateImageView(mainImageView, image)
    }
  }
  
  /// Метод `animateImageView`, который выполняет анимацию перехода
  /// между изображениями в заданном `UIImageView`.
  ///
  /// - Параметры:
  ///   - `imageView`: `UIImageView`, в котором будет обновлено изображение.
  ///   - `image`: Новое изображение для отображения.
  ///
  /// Метод использует `UIView.transition` для создания эффекта растворения
  /// (cross-dissolve) при смене изображения. Анимация длится заданное
  /// время, определенное в `Const.duration`, что обеспечивает плавный
  /// визуальный переход между текущим и новым изображением.
  private func animateImageView(_ imageView: UIImageView, _ image: UIImage?) {
    UIView.transition(
      with: self,
      duration: Const.duration,
      options: [.transitionCrossDissolve]
    ) {
      imageView.image = image
    }
  }
}

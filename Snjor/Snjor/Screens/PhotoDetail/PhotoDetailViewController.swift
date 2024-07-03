//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import Combine
import Photos

// swiftlint:disable all
class PhotoDetailViewController: UIViewController {
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private let viewModel: any PhotoDetailViewModelProtocol
  private var isAspectFill = true
  private var isPhotoInfo = true
  private let barButtonsView = BarButtonViews()

  // MARK: - Download
  let documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!

  let downloadService = DownloadService()

  lazy var downloadsSession: URLSession = {
    let configuration = URLSessionConfiguration.background(
      withIdentifier: "com.raywenderlich.HalfTunes.bgSession"
    )
    return URLSession(
      configuration: configuration,
      delegate: self,
      delegateQueue: nil
    )
  }()

  func localFilePath(for url: URL) -> URL {
    var destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
    if destinationURL.pathExtension.isEmpty {
      destinationURL = destinationURL.appendingPathExtension("jpg")
    }
    return destinationURL
  }

  // MARK: - Views
  private let uiContainerView: ContainerView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemBackground
    return $0
  }(ContainerView())

  // MARK: - Initializers
  init(viewModel: any PhotoDetailViewModelProtocol
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    stateController()
    configData()
    hidePhotoInfo()
    //    viewModel.viewDidLoad()
    downloadService.downloadsSession = downloadsSession
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
  }

  // MARK: - Private Methods
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.hideSpinner()
        switch state {
        case .success:
          self.configData()
        case .loading:
          //          self.showSpinner()
          print()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
          self.hideSpinner()
        }
      }
      .store(in: &cancellable)
  }

  private func configData() {
    uiContainerView.setupView()
    uiContainerView.mainPhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    uiContainerView.profilePhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    uiContainerView.nameLabel.text = viewModel.displayName
    uiContainerView.likesLabel.text = viewModel.likes
    uiContainerView.downloadsLabel.text = viewModel.downloads
    uiContainerView.viewsLabel.text = viewModel.views
    uiContainerView.createdAt(from: viewModel.createdAt)
    uiContainerView.cameraModelLabel.text = viewModel.cameraModel
    uiContainerView.resolutionLabel.text = viewModel.resolution
    uiContainerView.pxLabel.text = viewModel.pixels
    uiContainerView.isoLabel.text = viewModel.iso
    uiContainerView.focalLengthLabel.text = viewModel.focalLength
    uiContainerView.apertureLabel.text = viewModel.aperture
    uiContainerView.exposureTimeLabel.text = viewModel.exposureTime
  }

  private func setupUI() {
    setupBarButtonItems()
    view.addSubview(uiContainerView)
    NSLayoutConstraint.activate([
      uiContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      uiContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      uiContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      uiContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  private func setupBarButtonItems() {
    navigationItem.rightBarButtonItems = barButtonsView.makeRightBackBarButtons()
    navigationItem.leftBarButtonItems = barButtonsView.makeLeftBackBarButtons()
    configActions()
    barButtonsView.setupBarButtonView()
  }

  // MARK: - Actions
  private func configActions() {
    configInfoButtonAction()
    configBackButtonAction()
    configDownloadButtonAction()
    configToggleContentModeButtonAction()
  }

  private func configInfoButtonAction() {
    let infoButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.isPhotoInfo ? self.showPhotoInfo() : self.hidePhotoInfo()
      self.isPhotoInfo.toggle()
    }
    uiContainerView.infoButton.addAction(infoButtonAction, for: .touchUpInside)
  }

  private func configBackButtonAction() {
    let backButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.navigationController?.popViewController(animated: true)
    }
    barButtonsView.backBarButton.addAction(backButtonAction, for: .touchUpInside)
  }

  private func configDownloadButtonAction() {
    let downloadButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      downloadService.startDownload(viewModel.photo!)
      animateDownloadButton()
    }
    barButtonsView.downloadBarButton.addAction(downloadButtonAction, for: .touchUpInside)
  }

  private func animateDownloadButton() {
    UIView.animate(
      withDuration: 0.7,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0.5
    ) {
      self.barButtonsView.downloadBarButtonBlurView.frame.size.width = UIConst.buttonHeight
      self.barButtonsView.downloadBarButtonBlurView.frame.origin.x = UIConst.x
      self.barButtonsView.downloadBarButton.frame.size.width = UIConst.buttonHeight
      self.barButtonsView.downloadBarButton.setTitle(nil, for: .normal)
      self.barButtonsView.downloadBarButton.setImage(nil, for: .normal)

      self.barButtonsView.pauseBarButtonBlurView.frame.size.width = UIConst.buttonHeight
      self.barButtonsView.pauseBarButtonBlurView.isHidden = false
    }
  }

  private func configToggleContentModeButtonAction() {
    let toggleContentModeButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      configToggleContentMode()
    }
    barButtonsView.toggleContentModeButton.addAction(toggleContentModeButtonAction, for: .touchUpInside)
  }

  private func configToggleContentMode() {
    if self.isAspectFill {
      let icon = UIImage(systemName: .arrowDown)
      self.uiContainerView.mainPhotoImageView.contentMode = .scaleAspectFit
      self.barButtonsView.toggleContentModeButton.setImage(icon, for: .normal)
    } else {
      let icon = UIImage(systemName: .arrowUp)
      self.uiContainerView.mainPhotoImageView.contentMode = .scaleAspectFill
      self.barButtonsView.toggleContentModeButton.setImage(icon, for: .normal)
    }
    self.isAspectFill.toggle()
  }

  private func hidePhotoInfo() {
    UIView.animate(withDuration: 0.3) {
      self.uiContainerView.profileStackView.transform = CGAffineTransform(translationX: 0, y: -10)
      self.uiContainerView.photoInfoStackView.alpha = 0
      self.uiContainerView.gradientView.alpha = 0.4
      self.uiContainerView.photoInfoStackView.isHidden = true
    }
  }

  private func showPhotoInfo() {
    UIView.animate(
      withDuration: 0.7,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0.5
    ) {
      self.uiContainerView.gradientView.alpha = 1
      self.uiContainerView.photoInfoStackView.alpha = 1
      self.uiContainerView.mainStackView.transform = .identity
      self.uiContainerView.photoInfoStackView.isHidden = false
    }
  }


  private func saveImageToGallery(at url: URL) {
    PHPhotoLibrary.requestAuthorization { status in
      guard status == .authorized else {
        print("Photo library access not authorized.")
        return
      }

      PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      }) { success, error in
        if success {
          print("Successfully saved image to gallery.")
        } else if let error = error {
          print("Error saving image to gallery: \(error)")
        }
      }
    }
  }

}

// MARK: - MessageDisplayable
extension PhotoDetailViewController: MessageDisplayable { }

// MARK: - SpinnerDisplayable
extension PhotoDetailViewController: SpinnerDisplayable { }

// MARK: - URL Session Delegate
extension PhotoDetailViewController: URLSessionDelegate {
  func urlSessionDidFinishEvents(
    forBackgroundURLSession session: URLSession
  ) {
    DispatchQueue.main.async {
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
         let completionHandler = appDelegate.backgroundSessionCompletionHandler {
        appDelegate.backgroundSessionCompletionHandler = nil
        completionHandler()
      }
    }
  }
}

// MARK: - URL Session Download Delegate
extension PhotoDetailViewController: URLSessionDownloadDelegate {
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {

    guard let sourceURL = downloadTask.originalRequest?.url
    else {
      return
    }

    let download = downloadService.activeDownloads[sourceURL]
    downloadService.activeDownloads[sourceURL] = nil

    let destinationURL = localFilePath(for: sourceURL)
    print(destinationURL)

    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)

    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      saveImageToGallery(at: destinationURL)
    } catch let error {
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
  }

  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64
  ) {
    guard
      let url = downloadTask.originalRequest?.url,
      let download = downloadService.activeDownloads[url]
    else {
      return
    }

    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)

    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
  }
}

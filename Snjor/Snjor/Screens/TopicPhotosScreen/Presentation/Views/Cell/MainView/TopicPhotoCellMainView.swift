//
//  TopicPhotoCellMainView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

fileprivate typealias Const = TopicPhotoCellMainViewConst

final class TopicPhotoCellMainView: MainImageContainerView {
  // MARK: Delegate
  weak var delegate: (any TopicPhotoCellMainViewDelegate)?
  
  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? Const.maxOpacity : .zero
      gradientView.alpha = showsUsername ? Const.maxOpacity : .zero
    }
  }
  
  // MARK: Views
  let gradientView: MainGradientView = {
    let color = UIColor(
      white: .zero,
      alpha: Const.gradientOpacity
    )
    $0.setColors([
      MainGradientView.Color(
        color: .clear,
        location: Const.gradientStartLocation
      ),
      MainGradientView.Color(
        color: color,
        location: Const.gradientEndLocation
      )
    ])
    return $0
  }(MainGradientView())
  
  // MARK: Spinner
  lazy var spinner: UIActivityIndicatorView = {
    let xCenter = self.downloadButtonBlurEffect.contentView.bounds.midX
    let yCenter = self.downloadButtonBlurEffect.contentView.bounds.midY
    $0.center = CGPoint(x: xCenter, y: yCenter)
    $0.stopAnimating()
    $0.color = .label
    $0.transform = CGAffineTransform(
      scaleX: Const.spinnerScale,
      y: Const.spinnerScale
    )
    $0.alpha = Const.defaultOpacity
    $0.isHidden = true
    return $0
  }(UIActivityIndicatorView(style: .medium))
  
  // MARK: Blur Effects
  let downloadButtonBlurEffect: UIVisualEffectView = {
    $0.frame.size.width = Const.fullValue
    $0.frame.size.height = Const.fullValue
    $0.layer.cornerRadius = Const.defaultValue
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.fullValue
    ).isActive = true
    $0.heightAnchor.constraint(
      equalToConstant: Const.fullValue
    ).isActive = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))
  
  // MARK: Buttons
  lazy var downloadButton: UIButton = {
    let icon = SFSymbol.downloadCellButtonIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = Const.defaultOpacity
    $0.frame = downloadButtonBlurEffect.bounds
    return $0
  }(UIButton(type: .custom))
  
  // MARK: Labels
  let userNameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: Const.userNameLabelFontSize,
      weight: .medium
    )
    $0.numberOfLines = .zero
    return $0
  }(UILabel())

  // MARK: Initializers
  override init() {
    super.init()
    configDownloadButtonAction()
    setupPhotoCellViews()
  }

  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }

  // MARK: Setup Data
  func configure(
    with photo: Photo,
    showsUsername: Bool = true,
    url: URL?
  ) {
    super.configure(
      url: url,
      blurHash: photo.blurHash,
      photoID: photo.id
    )
    self.showsUsername = showsUsername
    userNameLabel.text = photo.user.displayName
  }
  
  func prepareForReuse() {
    reset()
  }
  
  private func reset() {
    currentPhotoID = nil
    mainImageView.image = nil
    userNameLabel.text = nil
    imageDownloader.cancel()
    downloadButton.isHidden = false
    spinner.isHidden = true
    spinner.stopAnimating()
  }
  
  // MARK: Setup Views
  private func setupPhotoCellViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(gradientView)
    addSubview(downloadButtonBlurEffect)
    addSubview(userNameLabel)
    downloadButtonBlurEffect.contentView.addSubview(downloadButton)
    downloadButtonBlurEffect.contentView.addSubview(spinner)
  }

  private func setupConstraints() {
    setupGradientConstraints()
    setupBlurEffectConstraints()
    setupUserNameLabelConstraints()
  }

  private func setupGradientConstraints() {
    gradientView.fillSuperView()
  }

  private func setupBlurEffectConstraints() {
    downloadButtonBlurEffect.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      pTop: Const.defaultValue,
      pRight: Const.defaultValue
    )
  }

  private func setupUserNameLabelConstraints() {
    userNameLabel.setConstraints(
      right:  mainImageView.rightAnchor,
      bottom: mainImageView.bottomAnchor,
      left: mainImageView.leftAnchor,
      pRight: Const.defaultValue,
      pBottom: Const.defaultValue,
      pLeft: Const.defaultValue
    )
  }

  // MARK: Config Actions
  private func configDownloadButtonAction() {
    let downloadButtonAction = downloadAction()
    addAction(downloadButtonAction)
  }

  private func downloadAction() -> UIAction {
    return UIAction { [weak self] _ in
      guard
        let self = self,
        let delegate = delegate
      else {
        return
      }
      animateButton()
      delegate.downloadTapped()
    }
  }

  private func addAction(_ action: UIAction) {
    downloadButton.addAction(
      action,
      for: .touchUpInside
    )
  }

  // MARK: Animate Buttons
  private func animateButton() {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: PhotoCellMainViewConst.scale,
        y: PhotoCellMainViewConst.scale
      )
      self.downloadButtonBlurEffect.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        self.downloadButton.isHidden = true
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        self.downloadButtonBlurEffect.transform = .identity
      }
    }
  }
}

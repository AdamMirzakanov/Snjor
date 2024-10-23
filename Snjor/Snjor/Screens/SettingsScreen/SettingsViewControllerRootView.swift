//
//  SettingsViewControllerRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.10.2024.
//

import UIKit

fileprivate typealias Const = SettingsViewControllerRootViewConst

final class SettingsViewControllerRootView: UIView {
  // MARK: Private Properties
  private let storage: any StorageManagerProtocol = StorageManager()
  private var buttonStates: [Bool] = [true, true, true, true, true, true, true, true, true]
  private lazy var buttonsArray: [UIButton] = [
    unColorCircleButton,
    blackAndWhiteCircleButton,
    greenCircleButton,
    yellowCircleButton,
    orangeCircleButton,
    redCircleButton,
    purpleCircleButton,
    blueCircleButton,
    tealCircleButton
  ]
  
  // MARK: Views
  private let scrollView: UIScrollView = {
    $0.alwaysBounceVertical = true
    return $0
  }(UIScrollView())
  
  private let firstLineView: UIView = {
    $0.backgroundColor = .systemGray
    $0.heightAnchor.constraint(
      equalToConstant: Const.lineHeight
    ).isActive = true
    return $0
  }(UIView())
  
  private let secondLineView: UIView = {
    $0.backgroundColor = .systemGray
    $0.heightAnchor.constraint(
      equalToConstant: Const.lineHeight
    ).isActive = true
    return $0
  }(UIView())
  
  // MARK: UILabel
  private let searchFiltersLabel: UILabel = {
    $0.text = Const.searchFiltersLabel
    $0.textColor = Const.colorOfTheSectionTitle
    $0.textAlignment = Const.sectionTitleTextAlignment
    $0.font = Const.fontOfTheSectionTitle
    return $0
  }(UILabel())
  
  private let colorFiltersLabel: UILabel = {
    $0.text = Const.colorFiltersLabelText
    $0.textColor = Const.colorOfTheSectionTitle
    $0.textAlignment = Const.sectionTitleTextAlignment
    $0.font = Const.fontOfTheSectionTitle
    return $0
  }(UILabel())
  
  private let orientationLabel: UILabel = {
    $0.text = Const.orientationLabelText
    $0.textColor = Const.systemGray
    $0.textAlignment = Const.standartTextAlignment
    $0.font = Const.standardFont
    return $0
  }(UILabel())
  
  private let sortingPhotosLabel: UILabel = {
    $0.text = Const.sortingPhotosLabelText
    $0.textColor = Const.systemGray
    $0.textAlignment = Const.standartTextAlignment
    $0.font = Const.standardFont
    return $0
  }(UILabel())
  
  // MARK: Bottons
  private let unColorCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = Const.colorOfTheSectionTitle
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let purpleCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemPurple
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let greenCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.tintColor = .systemGreen
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let yellowCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemYellow
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let orangeCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemOrange
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let redCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemPink
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let tealCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemTeal
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let blueCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemBlue
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let blackAndWhiteCircleButton: UIButton = {
    $0.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .white
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let resetButton: UIButton = {
    $0.setTitle(Const.resetButtonTitle, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = Const.standardFont
    $0.layer.cornerRadius = Const.resetButtonCornerRadius
    $0.heightAnchor.constraint(
      equalToConstant: Const.resetButtonHeight
    ).isActive = true
    $0.clipsToBounds = true
    $0.backgroundColor = Const.resetButtonColor
    return $0
  }(UIButton())
  
  // MARK: UISegmentedControl
  private lazy var orientationSegmentControl: UISegmentedControl = {
    $0.selectedSegmentTintColor = Const.selectedSegmentTintColor
    $0.selectedSegmentIndex = .zero
    $0.addTarget(
      self,
      action: #selector(orientationChanged),
      for: .valueChanged
    )
    return $0
  }(UISegmentedControl(
    items: [
      Const.all,
      SFSymbol.landscapeRectIcon,
      SFSymbol.portraitRectIcon,
      SFSymbol.squarishRectIcon
    ]
  ))
  
  private lazy var sortingPhotosSegmentControl: UISegmentedControl = {
    $0.selectedSegmentTintColor = Const.selectedSegmentTintColor
    $0.selectedSegmentIndex = .zero
    $0.addTarget(
      self,
      action: #selector(sortingPhotosChanged),
      for: .valueChanged
    )
    return $0
  }(UISegmentedControl(
    items: [
      Const.relevarntSort,
      Const.latestSort
    ]
  ))
  
  // MARK: UIStackView
  private lazy var circleButtonsStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.addArrangedSubview(unColorCircleButton)
    $0.addArrangedSubview(blackAndWhiteCircleButton)
    $0.addArrangedSubview(greenCircleButton)
    $0.addArrangedSubview(yellowCircleButton)
    $0.addArrangedSubview(orangeCircleButton)
    $0.addArrangedSubview(redCircleButton)
    $0.addArrangedSubview(purpleCircleButton)
    $0.addArrangedSubview(blueCircleButton)
    $0.addArrangedSubview(tealCircleButton)
    return $0
  }(UIStackView())
  
  private lazy var orientationStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.addArrangedSubview(orientationLabel)
    $0.addArrangedSubview(orientationSegmentControl)
    return $0
  }(UIStackView())
  
  private lazy var sortingPhotosStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.addArrangedSubview(sortingPhotosLabel)
    $0.addArrangedSubview(sortingPhotosSegmentControl)
    return $0
  }(UIStackView())
  
  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.spacing = Const.mainStackViewSpacing
    $0.addArrangedSubview(searchFiltersLabel)
    $0.addArrangedSubview(orientationStackView)
    $0.addArrangedSubview(sortingPhotosStackView)
    $0.addArrangedSubview(firstLineView)
    $0.addArrangedSubview(colorFiltersLabel)
    $0.addArrangedSubview(circleButtonsStackView)
    $0.addArrangedSubview(secondLineView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(resetButton)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
    restoreSelectedUIElement()
    setupButtonTargets()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  private func setupButtonTargets() {
    buttonsArray.forEach { $0.addTarget(
      self,
      action: #selector(circleButtonTapped),
      for: .touchUpInside)
    }
    resetButton.addTarget(
      self,
      action: #selector(resetButtonTapped),
      for: .touchUpInside
    )
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(scrollView)
    scrollView.addSubview(mainStackView)
  }
  
  private func setupConstraints() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(
        equalTo: scrollView.topAnchor,
        constant: Const.stackViewTopInset
      ),
      mainStackView.leadingAnchor.constraint(
        equalTo: scrollView.leadingAnchor,
        constant: Const.stackViewHorizontalInset
      ),
      mainStackView.trailingAnchor.constraint(
        equalTo: scrollView.trailingAnchor,
        constant: -Const.stackViewHorizontalInset
      ),
      mainStackView.bottomAnchor.constraint(
        equalTo: scrollView.bottomAnchor
      ),
      mainStackView.widthAnchor.constraint(
        equalTo: safeAreaLayoutGuide.widthAnchor,
        constant: Const.stackViewWidthAdjustment
      )
    ])
  }
  
  // MARK: Animate Buttons
  private func animateColorCircleButton(_ sender: UIButton) {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: Const.pressingColorCircleButtonScale,
        y: Const.pressingColorCircleButtonScale
      )
      sender.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        let scaleTransform = CGAffineTransform(
          scaleX: Const.colorCircleButtonScale,
          y: Const.colorCircleButtonScale
        )
        sender.transform = scaleTransform
      }
    }
  }
  
  private func animateResetButton(_ sender: UIButton) {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: Const.pressingResetButtonScale,
        y: Const.pressingResetButtonScale
      )
      sender.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        sender.transform = .identity
      }
    }
  }
  
  private func updateCircleButtonImage(for index: Int) {
    buttonStates[index].toggle()
    buttonsArray.enumerated().forEach { buttonIndex, button in
      if buttonIndex != index {
        button.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
        buttonStates[buttonIndex] = false
      } else {
        if buttonIndex == .zero {
          button.setImage(SFSymbol.unColorCheckedCircleImage, for: .normal)
          buttonStates[buttonIndex] = true
        } else {
          button.setImage(SFSymbol.checkedCircleImage, for: .normal)
          buttonStates[buttonIndex] = true
        }
        
      }
    }
    storage.set(index, forKey: .selectedCircleButtonIndexKey)
    
    let queryParameter: String
    switch index {
    case Const.whiteButton:
      queryParameter = ParamValue.blackAndWhite.rawValue
    case Const.greenButton:
      queryParameter = ParamValue.green.rawValue
    case Const.yellowButton:
      queryParameter = ParamValue.yellow.rawValue
    case Const.orangeButton:
      queryParameter = ParamValue.orange.rawValue
    case Const.redButton:
      queryParameter = ParamValue.red.rawValue
    case Const.purpleButton:
      queryParameter = ParamValue.purple.rawValue
    case Const.blueButton:
      queryParameter = ParamValue.blue.rawValue
    case Const.tealButton:
      queryParameter = ParamValue.teal.rawValue
    default:
      queryParameter = .empty
      storage.remove(forKey: .selectedCircleButtonKey)
    }
    
    storage.set(queryParameter, forKey: .selectedCircleButtonKey)
  }
  
  // MARK: Objc Methods
  @objc private func circleButtonTapped(_ sender: UIButton) {
    animateColorCircleButton(sender)
    guard let index = buttonsArray.firstIndex(of: sender) else { return }
    updateCircleButtonImage(for: index)
  }
  
  @objc private func resetButtonTapped(_ sender: UIButton) {
    animateResetButton(sender)
    orientationSegmentControl.selectedSegmentIndex = .zero
    sortingPhotosSegmentControl.selectedSegmentIndex = .zero
    storage.remove(forKey: .photoOrientationKey)
    storage.remove(forKey: .photoOrientationSegmentIndexKey)
    storage.remove(forKey: .sortingPhotosSegmentIndexKey)
    storage.remove(forKey: .sortingPhotosKey)
    storage.remove(forKey: .selectedCircleButtonKey)
    storage.remove(forKey: .selectedCircleButtonIndexKey)
    buttonsArray.enumerated().forEach { index, button in
      if index == .zero {
        button.setImage(SFSymbol.unColorCheckedCircleImage, for: .normal)
      } else {
        button.setImage(SFSymbol.uncheckedCircleImage, for: .normal)
      }
    }
  }
  
  @objc private func orientationChanged(_ sender: UISegmentedControl) {
    storage.set(
      sender.selectedSegmentIndex,
      forKey: .photoOrientationSegmentIndexKey
    )
    
    if sender.selectedSegmentIndex == Const.allOrientationsSegmentIndex {
      storage.remove(forKey: .photoOrientationKey)
    } else {
      let queryParameter: String
      switch sender.selectedSegmentIndex {
      case Const.landscapeOrientationSegmentIndex:
        queryParameter = ParamValue.landscape.rawValue
      case Const.portraitOrientationSegmentIndex:
        queryParameter = ParamValue.portrait.rawValue
      case Const.squarishOrientationSegmentIndex:
        queryParameter = ParamValue.squarish.rawValue
      default:
        return
      }
      storage.set(
        queryParameter,
        forKey: .photoOrientationKey
      )
    }
  }
  
  @objc private func sortingPhotosChanged(_ sender: UISegmentedControl) {
    storage.set(
      sender.selectedSegmentIndex,
      forKey: .sortingPhotosSegmentIndexKey
    )
    
    if sender.selectedSegmentIndex == Const.relevarntSegmentIndex {
      storage.remove(forKey: .sortingPhotosKey)
    }
    
    let queryParameter: String
    switch sender.selectedSegmentIndex {
    case Const.latestSegmentIndex:
      queryParameter = ParamValue.latest.rawValue
    default:
      return
    }
    
    storage.set(queryParameter, forKey: .sortingPhotosKey)
  }
  
  // MARK: State Restoration
  private func restoreSelectedUIElement() {
    let selectedOrientationSegmentIndex = storage.int(
      forKey: .photoOrientationSegmentIndexKey
    ) ?? .zero
    orientationSegmentControl.selectedSegmentIndex = selectedOrientationSegmentIndex
    
    let selectedSortingPhotosSegmentIndex = storage.int(
      forKey: .sortingPhotosSegmentIndexKey
    ) ?? .zero
    sortingPhotosSegmentControl.selectedSegmentIndex = selectedSortingPhotosSegmentIndex
    
    let selectedCircleButtonIndex = storage.int(
      forKey: .selectedCircleButtonIndexKey
    ) ?? .zero
    updateCircleButtonImage(for: selectedCircleButtonIndex)
  }
}

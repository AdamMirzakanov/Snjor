//
//  SettingsViewControllerRootViewConst.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.10.2024.
//

import UIKit

enum SettingsViewControllerRootViewConst {
 
  static let selectedSegmentTintColor: UIColor = .systemBlue
  static let resetButtonColor: UIColor = .white
  static let colorOfTheSectionTitle: UIColor = .systemGray3
  static let systemGray: UIColor = .systemGray
  
  static let fontOfTheSectionTitle: UIFont = .systemFont(ofSize: 25, weight: .bold)
  static let standardFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
  static let resetButtonFont: UIFont = .systemFont(ofSize: 20, weight: .regular)
  
  static let sectionTitleTextAlignment: NSTextAlignment = .left
  static let standartTextAlignment: NSTextAlignment = .left
  
  static let resetButtonCornerRadius: CGFloat = 8.0
  static let resetButtonHeight: CGFloat = 40.0
  static let lineHeight: CGFloat = 1.0
  static let lineColor: UIColor = .systemGray
  static let mainStackViewSpacing: CGFloat = 20.0
  static let stackViewTopInset: CGFloat = 15.0
  static let stackViewHorizontalInset: CGFloat = 20.0
  static let stackViewWidthAdjustment: CGFloat = -40.0
  static let colorImageViewSize: CGFloat = 30.0
  static let colorCirclOpasity: CGFloat = 1.0
  static let pressingResetButtonScale: CGFloat = 0.95
  static let pressingColorCircleButtonScale: CGFloat = 0.9
  static let colorCircleButtonScale: CGFloat = 1.4
  static let duration: CGFloat = 0.12
  
  static let relevarntSegmentIndex: Int = 0
  static let latestSegmentIndex: Int = 1
  
  static let allOrientationsSegmentIndex: Int = 0
  static let landscapeOrientationSegmentIndex: Int = 1
  static let portraitOrientationSegmentIndex: Int = 2
  static let squarishOrientationSegmentIndex: Int = 3
  
  static let unColoerButton: Int = 0
  static let whiteButton: Int = 1
  static let greenButton: Int = 2
  static let yellowButton: Int = 3
  static let orangeButton: Int = 4
  static let redButton: Int = 5
  static let purpleButton: Int = 6
  static let blueButton: Int = 7
  static let tealButton: Int = 8
  
  // Localizable
  static var resetButtonTitle: String {
    Key.resetButtonTitle.localizeString()
  }
  
  static var colorFiltersLabelText: String {
    Key.colorFiltersLabelText.localizeString()
  }
  
  static var searchFiltersLabel: String {
    Key.searchFiltersLabel.localizeString()
  }
  
  static var orientationLabelText: String {
    Key.orientationLabelText.localizeString()
  }
  
  static var sortingPhotosLabelText: String {
    Key.sortingPhotosLabelText.localizeString()
  }
  
  static var relevarntSort: String {
    Key.relevarntSort.localizeString()
  }
  
  static var latestSort: String {
    Key.latestSort.localizeString()
  }
  
  static var anyOrientation: String {
    Key.anyOrientation.localizeString()
  }
}

// MARK: - Localizable Keys
private enum Key: String, CaseIterable {
  case resetButtonTitle = "reset_Button_Title_Key"
  case colorFiltersLabelText = "color_Filters_Label_Text_Key"
  case searchFiltersLabel = "search_Filters_Label_Key"
  case orientationLabelText = "orientation_Label_Text_Key"
  case sortingPhotosLabelText = "sorting_Photos_Label_Text_Key"
  case relevarntSort = "relevarnt_Sort_Key"
  case latestSort = "latest_Sort_Key"
  case anyOrientation = "any_Orientation_Key"
  
  func localizeString() -> String {
    NSLocalizedString(self.rawValue, comment: .empty )
  }
}

//
//  PhotoDetail + URLSessionDelegate.swift
//  Snjor
//
//  Created by Адам on 04.07.2024.
//

import UIKit

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

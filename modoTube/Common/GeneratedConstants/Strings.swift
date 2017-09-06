// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// close
  case commonClose
  /// home
  case mTubeVideoViewControllerTitle
  /// check your internet connection
  case mtvViewControllerAlertReminderMessage
  /// no internet connection
  case mtvViewControllerAlertReminderTitle
  /// please wait
  case mtvViewControllerHUDRequestSubtitle
  /// loading data
  case mtvViewControllerHUDRequestTitle
  /// modotube
  case mtvViewControllerLabelPresentationText
  /// send
  case mtvViewControllerSendButtonName
  /// enter your video name
  case mtvViewControllerTfSearchPlaceholder
  /// please check if you fill your API key
  case mtvViewControllerYoutubeAlertMessage
  /// can't fetch
  case mtvViewControllerYoutubeAlertTitle
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .commonClose:
        return L10n.tr(key: "common.close")
      case .mTubeVideoViewControllerTitle:
        return L10n.tr(key: "MTubeVideoViewController.title")
      case .mtvViewControllerAlertReminderMessage:
        return L10n.tr(key: "MTVViewController.alertReminder.message")
      case .mtvViewControllerAlertReminderTitle:
        return L10n.tr(key: "MTVViewController.alertReminder.title")
      case .mtvViewControllerHUDRequestSubtitle:
        return L10n.tr(key: "MTVViewController.HUDRequest.subtitle")
      case .mtvViewControllerHUDRequestTitle:
        return L10n.tr(key: "MTVViewController.HUDRequest.title")
      case .mtvViewControllerLabelPresentationText:
        return L10n.tr(key: "MTVViewController.labelPresentation.text")
      case .mtvViewControllerSendButtonName:
        return L10n.tr(key: "MTVViewController.sendButton.name")
      case .mtvViewControllerTfSearchPlaceholder:
        return L10n.tr(key: "MTVViewController.tfSearch.placeholder")
      case .mtvViewControllerYoutubeAlertMessage:
        return L10n.tr(key: "MTVViewController.youtubeAlert.message")
      case .mtvViewControllerYoutubeAlertTitle:
        return L10n.tr(key: "MTVViewController.youtubeAlert.title")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}

private final class BundleToken {}

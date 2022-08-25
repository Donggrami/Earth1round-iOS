// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let darkGrey = ColorAsset(name: "DarkGrey")
    internal static let darkYellow = ColorAsset(name: "DarkYellow")
    internal static let grey10 = ColorAsset(name: "Grey10")
    internal static let grey20 = ColorAsset(name: "Grey20")
    internal static let grey30 = ColorAsset(name: "Grey30")
    internal static let grey40 = ColorAsset(name: "Grey40")
    internal static let lightYellow = ColorAsset(name: "LightYellow")
    internal static let mainYellow = ColorAsset(name: "MainYellow")
    internal static let pointBlue = ColorAsset(name: "PointBlue")
    internal static let subYellow = ColorAsset(name: "SubYellow")
    internal static let white = ColorAsset(name: "White")
  }
  internal enum Images {
    internal static let image = ImageAsset(name: "Image")
    internal static let activePlace = ImageAsset(name: "activePlace")
    internal static let chaHomeBack = ImageAsset(name: "chaHomeBack")
    internal static let chaHomeBadge = ImageAsset(name: "chaHomeBadge")
    internal static let chaHomeEarth = ImageAsset(name: "chaHomeEarth")
    internal static let chaHomeNavi = ImageAsset(name: "chaHomeNavi")
    internal static let cha01 = ImageAsset(name: "cha_01")
    internal static let cha02 = ImageAsset(name: "cha_02")
    internal static let cha03 = ImageAsset(name: "cha_03")
    internal static let cha04 = ImageAsset(name: "cha_04")
    internal static let cha05 = ImageAsset(name: "cha_05")
    internal static let cha06 = ImageAsset(name: "cha_06")
    internal static let cha07 = ImageAsset(name: "cha_07")
    internal static let goHomeButton = ImageAsset(name: "goHomeButton")
    internal static let homeBack01 = ImageAsset(name: "homeBack01")
    internal static let homeBack02 = ImageAsset(name: "homeBack02")
    internal static let homeButton = ImageAsset(name: "homeButton")
    internal static let homeMsgBox = ImageAsset(name: "homeMsgBox")
    internal static let homePercent = ImageAsset(name: "homePercent")
    internal static let leftArrowButton = ImageAsset(name: "leftArrowButton")
    internal static let placeIcon = ImageAsset(name: "placeIcon")
    internal static let rightArrowButton = ImageAsset(name: "rightArrowButton")
    internal static let settingArrowButton = ImageAsset(name: "settingArrowButton")
    internal static let unactivePlace = ImageAsset(name: "unactivePlace")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

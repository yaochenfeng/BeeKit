public struct Constant {
    // swiftlint:disable colon force_cast force_unwrapping
    public static let bundleID:String = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    public static let version:String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    public static let buildNum:String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    // swiftlint:enable colon force_cast force_unwrapping
}

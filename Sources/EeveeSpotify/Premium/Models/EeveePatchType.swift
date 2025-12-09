import Foundation

enum GalapagamePatchType: Int {
    case notSet
    case disabled
    case requests
    
    var isPatching: Bool { self == .requests }
}

import UIKit
import Orion

struct HookTargetNameHelper {
    static var lyricsScrollProvider: String {
        switch GalapagameSpotify.hookTarget {
        case .lastAvailableiOS14: return "Lyrics_CoreImpl.ScrollProvider"
        default: return "Lyrics_NPVCommunicatorImpl.ScrollProvider"
        }
    }
}

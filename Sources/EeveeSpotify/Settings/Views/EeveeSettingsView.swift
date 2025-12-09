import SwiftUI
import UIKit

struct GalapagameSettingsView: View {
    let navigationController: UINavigationController
    static let spotifyAccentColor = Color(hex: "#1ed760")
    
    @State private var hasShownCommonIssuesTip = UserDefaults.hasShownCommonIssuesTip
    @State private var isClearingData = false
    
    private func pushSettingsController(with view: any View, title: String) {
        let viewController = GalapagameSettingsViewController(
            navigationController.view.frame,
            settingsView: AnyView(view),
            navigationTitle: title
        )
        navigationController.pushViewController(viewController, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        UIView.appearance().tintColor = UIColor(GalapagameSettingsView.spotifyAccentColor)
    }

    var body: some View {
        List {
            GalapagameSettingsVersionView()
            
            if !hasShownCommonIssuesTip {
                CommonIssuesTipView(
                    onDismiss: {
                        hasShownCommonIssuesTip = true
                        UserDefaults.hasShownCommonIssuesTip = true
                    }
                )
            }
            
            //
            
            Button {
                pushSettingsController(
                    with: GalapagamePatchingSettingsView(),
                    title: "patching".localized
                )
            } label: {
                NavigationSectionView(
                    color: .orange,
                    title: "patching".localized,
                    imageSystemName: "hammer.fill"
                )
            }
            
            Button {
                pushSettingsController(
                    with: GalapagameLyricsSettingsView(),
                    title: "lyrics".localized
                )
            } label: {
                NavigationSectionView(
                    color: .blue,
                    title: "lyrics".localized,
                    imageSystemName: "quote.bubble.fill"
                )
            }
            
            Button {
                pushSettingsController(
                    with: GalapagameUISettingsView(),
                    title: "customization".localized
                )
            } label: {
                NavigationSectionView(
                    color: Color(hex: "#64D2FF"),
                    title: "customization".localized,
                    imageSystemName: "paintpalette.fill"
                )
            }
            
            Button {
                pushSettingsController(
                    with: GalapagameExperimentsSettingsView(),
                    title: "experiments".localized
                )
            } label: {
                NavigationSectionView(
                    color: .purple,
                    title: "experiments".localized,
                    imageSystemName: "sparkle"
                )
            }
            
            //
            
            Section(footer: Text("reset_data_description".localized)) {
                Button {
                    isClearingData = true
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        OfflineHelper.resetData(clearCaches: true)
                        
                        DispatchQueue.main.async {
                            exitApplication()
                        }
                    }
                } label: {
                    if isClearingData {
                        ProgressView()
                    }
                    else {
                        Text("reset_data".localized)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        
        .animation(.default, value: isClearingData)
        .animation(.default, value: hasShownCommonIssuesTip)
        
        .onAppear {
            WindowHelper.shared.overrideUserInterfaceStyle(.dark)
        }
    }
}

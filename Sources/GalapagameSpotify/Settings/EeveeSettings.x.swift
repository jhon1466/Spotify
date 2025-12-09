import Orion
import SwiftUI
import UIKit

class ProfileSettingsSectionHook: ClassHook<NSObject> {
    static let targetName = "ProfileSettingsSection"

    func numberOfRows() -> Int {
        return 2
    }

    func didSelectRow(_ row: Int) {
        if row == 1 {
            let rootSettingsController = WindowHelper.shared.findFirstViewController(
                "RootSettingsViewController"
            )!
            
            let navigationController = rootSettingsController.navigationController!

            let GalapagameSettingsController = GalapagameSettingsViewController(
                rootSettingsController.view.bounds,
                settingsView: AnyView(GalapagameSettingsView(navigationController: navigationController)),
                navigationTitle: "GalapagameSpotify"
            )
            
            //
            
            let button = UIButton()

            button.setImage(
                BundleHelper.shared.uiImage("github").withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            
            button.addTarget(
                GalapagameSettingsController,
                action: #selector(GalapagameSettingsController.openRepositoryUrl(_:)),
                for: .touchUpInside
            )
            
            //
            
            let menuBarItem = UIBarButtonItem(customView: button)
            
            menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
            menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 22).isActive = true

            GalapagameSettingsController.navigationItem.rightBarButtonItem = menuBarItem
            
            navigationController.pushViewController(
                GalapagameSettingsController,
                animated: true
            )

            return
        }

        orig.didSelectRow(row)
    }

    func cellForRow(_ row: Int) -> UITableViewCell {
        if row == 1 {
            let settingsTableCell = Dynamic.SPTSettingsTableViewCell
                .alloc(interface: SPTSettingsTableViewCell.self)
                .initWithStyle(3, reuseIdentifier: "GalapagameSpotify")
            
            let tableViewCell = Dynamic.convert(settingsTableCell, to: UITableViewCell.self)

            tableViewCell.accessoryView = type(
                of: Dynamic.SPTDisclosureAccessoryView
                    .alloc(interface: SPTDisclosureAccessoryView.self)
            )
            .disclosureAccessoryView()
            
            tableViewCell.textLabel?.text = "GalapagameSpotify"
            return tableViewCell
        }

        return orig.cellForRow(row)
    }
}

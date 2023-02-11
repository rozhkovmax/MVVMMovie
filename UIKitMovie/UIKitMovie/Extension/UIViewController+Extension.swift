// UIViewController+Extension.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Расширение для вызова AlertController
extension UIViewController {
    func showAlertController(
        alertTitle: String?,
        alertMessage: String?,
        alertActionTitle: String?,
        handler: ((UIAlertAction) -> ())?
    ) {
        let alertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        let alertControllerAction = UIAlertAction(
            title: alertActionTitle,
            style: .default,
            handler: handler
        )
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }

    func showKeyChainAlert(
        alertTitle: String?,
        alertMessage: String?,
        alertActionTitle: String?,
        handler: StringHandler
    ) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: alertActionTitle, style: .default) { _ in
            let result = alertController.textFields?.first?.text ?? ""
            handler?(result)
        }
        alertController.addTextField()
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}

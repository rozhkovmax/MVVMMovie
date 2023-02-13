// MockKeyChainService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

@testable import UIKitMovie

/// Мок сервиса для сохранения критических данных
final class MockKeyChainService: KeyChainServiceProtocol {
    // MARK: - Public Methods

    func getAPIKey(_ key: String) -> String {
        String()
    }

    func saveAPIKey(_ value: String, forKey: String) {}
}

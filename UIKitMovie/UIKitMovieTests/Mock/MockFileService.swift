// MockFileService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

@testable import UIKitMovie

/// Мок  файл менеджера
final class MockFileService: FileServiceProtocol {
    // MARK: - Public Methods
    
    func getImageFromCache(url: String) -> Data? {
        Data()
    }
    
    func saveImageToCache(url: String, data: Data) {}
}

// FileServiceProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Протокол файл менеджера
protocol FileServiceProtocol {
    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data)
    func getImageFromCache(url: String) -> Data?
}

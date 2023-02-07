// FileManagerServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол файл менеджера
protocol FileManagerServiceProtocol {
    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data)
    func getImageFromCache(url: String) -> Data?
}

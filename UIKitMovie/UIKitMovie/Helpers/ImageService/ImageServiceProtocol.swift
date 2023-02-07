// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сервиса запроса изображения
protocol ImageServiceProtocol {
    // MARK: - Public Methods

    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

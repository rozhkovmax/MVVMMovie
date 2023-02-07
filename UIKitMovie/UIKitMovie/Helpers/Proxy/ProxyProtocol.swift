// ProxyProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол прокси
protocol ProxyProtocol {
    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

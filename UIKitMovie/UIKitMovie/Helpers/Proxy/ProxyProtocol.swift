// ProxyProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Протокол прокси
protocol ProxyProtocol {
    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

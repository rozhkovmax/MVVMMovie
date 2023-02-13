// MockProxy.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

@testable import UIKitMovie

/// Мок  прокси
final class MockProxy: ProxyProtocol {
    // MARK: - Public Methods

    func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {}
}

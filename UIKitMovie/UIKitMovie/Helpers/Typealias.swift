// Typealias.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

// Псевдонимы типа
// swiftlint:disable all
typealias VoidHandler = () -> Void
typealias ErrorHandler = (Error) -> Void
typealias DataHandler = (Data) -> Void
typealias StringHandler = ((String) -> Void)?
typealias AlertHandler = (String) -> Void
// swiftlint:enable all

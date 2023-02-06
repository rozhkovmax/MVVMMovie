// WebViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

import WebKit

/// Контроллер веб страницы
final class WebViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let webTitleText = "https://www.kinopoisk.ru"
        static let blackCustomColor = UIColor(named: "blackCustomColor")
        static let yellowCustomColor = UIColor(named: "yellowCustomColor")
        static let whiteCustomColor = UIColor(named: "whiteCustomColor")
    }

    // MARK: Private Visual Component

    private let webToolBar = UIToolbar()
    private let goBackBarButtonItem = UIBarButtonItem(systemItem: .rewind)
    private let goForwardBarButtonItem = UIBarButtonItem(systemItem: .fastForward)
    private let spaceBarButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
    private let refreshBarButtonItem = UIBarButtonItem(systemItem: .refresh)
    private let webProgressView = UIProgressView()

    // MARK: - Private Properties

    private let webView = WKWebView()
    private var observer: NSKeyValueObservation?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        createWebView()
        createToolBar()
        createProgressView()
        createProgressViewConstraint()
        createWebViewConstraint()
        createToolBarConstraint()
    }

    private func createProgressView() {
        view.addSubview(webProgressView)
        observer = webView.observe(\.estimatedProgress, options: [.new]) { _, _ in
            self.webProgressView.progress = Float(self.webView.estimatedProgress)
        }
        webProgressView.tintColor = Constants.yellowCustomColor
        webProgressView.trackTintColor = Constants.whiteCustomColor
    }

    private func createProgressViewConstraint() {
        webProgressView.translatesAutoresizingMaskIntoConstraints = false
        webProgressView.leftAnchor.constraint(equalTo: webView.leftAnchor, constant: 140).isActive = true
        webProgressView.rightAnchor.constraint(equalTo: webView.rightAnchor, constant: -100).isActive = true
        webProgressView.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: -23).isActive = true
        webProgressView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        webProgressView.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
    }

    private func createWebView() {
        view.addSubview(webView)
        guard let url = URL(string: Constants.webTitleText) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        webView.navigationDelegate = self
    }

    private func createWebViewConstraint() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func createToolBar() {
        view.addSubview(webToolBar)
        webToolBar.isTranslucent = false
        webToolBar.items = [
            goBackBarButtonItem,
            goForwardBarButtonItem,
            spaceBarButtonItem,
            refreshBarButtonItem
        ]
        goBackBarButtonItem.action = #selector(goBackItemAction)
        goForwardBarButtonItem.action = #selector(goForwardItemAction)
        refreshBarButtonItem.action = #selector(refreshItemAction)
        webToolBar.barTintColor = Constants.blackCustomColor
        webToolBar.tintColor = Constants.yellowCustomColor
    }

    private func createToolBarConstraint() {
        webToolBar.translatesAutoresizingMaskIntoConstraints = false
        webToolBar.leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
        webToolBar.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
        webToolBar.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
        webToolBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc private func goBackItemAction() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc private func goForwardItemAction() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @objc private func refreshItemAction() {
        webView.reload()
    }
}

// MARK: - UIWebViewDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        goBackBarButtonItem.isEnabled = webView.canGoBack
        goForwardBarButtonItem.isEnabled = webView.canGoForward
    }
}

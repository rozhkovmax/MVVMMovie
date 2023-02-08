// DetailMovieViewController.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Описание фильма
final class DetailMovieViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let dateOfReleaseText = "Дата релиза:"
        static let popularityText = "Популярность:"
        static let originalTitleText = "Оригинальное название:"
        static let myUIKitMovieText = "https://github.com/rozhkovmax/UIKitMovie"
        static let rightBarButtonItemImageName = "square.and.arrow.up"
        static let blackCustomColor = UIColor(named: "blackCustomColor")
        static let yellowCustomColor = UIColor(named: "yellowCustomColor")
        static let whiteCustomColor = UIColor(named: "whiteCustomColor")
        static let alertTitle = "Ошибка"
        static let alertActionTitle = "OK"
        static let fatalErrorText = "Критическая ошибка"
    }

    // MARK: Private Visual Component

    private let filmImageView = UIImageView()
    private let filmOriginLabel = CustomLabel()
    private let filmFeatureLabel = CustomLabel()
    private let filmDescriptionLabel = CustomLabel()

    // MARK: - Public Properties

    var detailMovieViewModel: DetailMovieViewModelProtocol?

    // MARK: - Initializers

    init(detailMovieViewModel: DetailMovieViewModelProtocol) {
        self.detailMovieViewModel = detailMovieViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        createVisualPresentation()
        createFilmImageView()
        createFilmOriginLabel()
        createFilmFeatureLabel()
        createFilmDescriptionLabel()
        createFilmImageViewConstraint()
        createFilmOriginLabelConstraint()
        createFilmFeatureLabelConstraint()
        createFilmDescriptionLabelConstraint()
    }

    private func createVisualPresentation() {
        view.backgroundColor = Constants.blackCustomColor
        title = detailMovieViewModel?.film?.title
        navigationController?.navigationBar
            .titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.yellowCustomColor as Any]
        navigationController?.navigationBar.tintColor = Constants.yellowCustomColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.rightBarButtonItemImageName),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonAction)
        )
    }

    private func createFilmImageView() {
        view.addSubview(filmImageView)
        filmImageView.backgroundColor = Constants.blackCustomColor
        filmImageView.layer.cornerRadius = 10
        filmImageView.clipsToBounds = true
        filmImageView.contentMode = .scaleToFill
        filmImageView.layer.borderWidth = 1
        filmImageView.layer.borderColor = Constants.yellowCustomColor?.cgColor
        guard let imagePath = detailMovieViewModel?.film?.backdropPath else { return }
        fetchImage(url: imagePath)
    }

    private func fetchImage(url: String) {
        detailMovieViewModel?.fetchImage(url: url) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.filmImageView.image = UIImage(data: data)
            }
        }
    }

    private func createFilmImageViewConstraint() {
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        filmImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        filmImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        filmImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }

    private func createFilmOriginLabel() {
        view.addSubview(filmOriginLabel)
        filmOriginLabel.backgroundColor = Constants.blackCustomColor
        filmOriginLabel.numberOfLines = 0
        filmOriginLabel.adjustsFontSizeToFitWidth = true
        filmOriginLabel.textAlignment = .center
        filmOriginLabel.layer.cornerRadius = 10
        filmOriginLabel.clipsToBounds = true
        filmOriginLabel.layer.borderWidth = 1
        filmOriginLabel.layer.borderColor = Constants.yellowCustomColor?.cgColor
        filmOriginLabel.textColor = Constants.whiteCustomColor
        filmOriginLabel.padding(top: 0, bottom: 0, left: 10, right: 10)
        guard let originTitle = detailMovieViewModel?.film?.originalTitle,
              let originLanguage = detailMovieViewModel?.film?.originalLanguage else { return }
        filmOriginLabel.attributedText = NSMutableAttributedString()
            .normal("\(Constants.originalTitleText) \n")
            .bold("\(originTitle) (\(originLanguage.uppercased()))")
    }

    private func createFilmOriginLabelConstraint() {
        filmOriginLabel.translatesAutoresizingMaskIntoConstraints = false
        filmOriginLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 10).isActive = true
        filmOriginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        filmOriginLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        filmOriginLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func createFilmFeatureLabel() {
        view.addSubview(filmFeatureLabel)
        filmFeatureLabel.backgroundColor = Constants.blackCustomColor
        filmFeatureLabel.numberOfLines = 0
        filmFeatureLabel.adjustsFontSizeToFitWidth = true
        filmFeatureLabel.textAlignment = .center
        filmFeatureLabel.padding(top: 0, bottom: 0, left: 10, right: 10)
        filmFeatureLabel.layer.cornerRadius = 10
        filmFeatureLabel.clipsToBounds = true
        filmFeatureLabel.layer.borderWidth = 1
        filmFeatureLabel.layer.borderColor = Constants.yellowCustomColor?.cgColor
        filmFeatureLabel.textColor = Constants.whiteCustomColor
        guard let popularity = detailMovieViewModel?.film?.popularity,
              let dateOfRelease = detailMovieViewModel?.film?.releaseDate else { return }
        filmFeatureLabel.attributedText = NSMutableAttributedString()
            .normal("\(Constants.dateOfReleaseText) \(dateOfRelease) \n \(Constants.popularityText) \(popularity)")
    }

    private func createFilmFeatureLabelConstraint() {
        filmFeatureLabel.translatesAutoresizingMaskIntoConstraints = false
        filmFeatureLabel.topAnchor.constraint(equalTo: filmOriginLabel.bottomAnchor, constant: 10).isActive = true
        filmFeatureLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        filmFeatureLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        filmFeatureLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func createFilmDescriptionLabel() {
        view.addSubview(filmDescriptionLabel)
        filmDescriptionLabel.backgroundColor = Constants.blackCustomColor
        filmDescriptionLabel.numberOfLines = 0
        filmDescriptionLabel.adjustsFontSizeToFitWidth = true
        filmDescriptionLabel.textAlignment = .justified
        filmDescriptionLabel.padding(top: 0, bottom: 0, left: 20, right: 20)
        filmDescriptionLabel.layer.cornerRadius = 10
        filmDescriptionLabel.clipsToBounds = true
        filmDescriptionLabel.text = detailMovieViewModel?.film?.overview
        filmDescriptionLabel.layer.borderWidth = 1
        filmDescriptionLabel.layer.borderColor = Constants.yellowCustomColor?.cgColor
        filmDescriptionLabel.textColor = Constants.whiteCustomColor
    }

    private func createFilmDescriptionLabelConstraint() {
        filmDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        filmDescriptionLabel.topAnchor.constraint(equalTo: filmFeatureLabel.bottomAnchor, constant: 10).isActive = true
        filmDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        filmDescriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        filmDescriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }

    @objc private func rightBarButtonAction() {
        guard let titleText = detailMovieViewModel?.film?.title else { return }
        let buttonActivityViewController = UIActivityViewController(
            activityItems: [titleText],
            applicationActivities: nil
        )
        present(buttonActivityViewController, animated: true)
    }
}

// ListMovieTableViewCell.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Ячейка фильма
final class ListMovieTableViewCell: UITableViewCell {
    // MARK: - Private Constants
    
    private enum Constants {
        static let fatalErrorText = "Критическая ошибка"
        static let fontNameHelveticaBold = "Helvetica-Bold"
        static let fontNameAmericanTypewriterBold = "AmericanTypewriter-Bold"
        static let fontNameAvenirBlack = "Avenir-Black"
        static let blackCustomColor = UIColor(named: "blackCustomColor")
        static let yellowCustomColor = UIColor(named: "yellowCustomColor")
        static let darkGrayCustomColor = UIColor(named: "darkGrayCustomColor")
        static let grayCustomColor = UIColor(named: "grayCustomColor")
        static let lightGrayCustomColor = UIColor(named: "lightGrayCustomColor")
        static let errorText = "Ошибка"
    }
    
    // MARK: Private Visual Component
    
    private let movieImageView = UIImageView()
    private let movieTitleLabel = UILabel()
    private let movieOverviewLabel = CustomLabel()
    private let movieRatingLabel = UILabel()
    
    // MARK: - Public Properties
    
    weak var alertDelegate: AlertDelegate?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    // MARK: - Public Methods
    
    func configure(index: Int, listMovieViewModel: ListMovieViewModelProtocol) {
        if case let .success(movies) = listMovieViewModel.listMovieProps {
            let movie = movies[index]
            guard let imagePath = movie.posterPath else { return }
            fetchImage(url: imagePath, listMovieViewModel: listMovieViewModel)
            movieTitleLabel.text = movie.title
            movieOverviewLabel.text = movie.overview
            movieRatingLabel.text = String(describing: movie.voteAverage)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        createMovieImageView()
        createMovieTitleLabel()
        createMovieOverviewLabel()
        createMovieRatingLabel()
        createVisualPresentation()
        createMovieRatingLabelConstraint()
        createMovieImageViewConstraint()
        createMovieTitleLabelConstraint()
        createMovieOverviewLabelConstraint()
    }
    
    private func fetchImage(url: String, listMovieViewModel: ListMovieViewModelProtocol) {
        listMovieViewModel.fetchImage(url: url) { [weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func createVisualPresentation() {
        contentView.backgroundColor = Constants.blackCustomColor
    }
    
    private func createMovieRatingLabel() {
        contentView.addSubview(movieRatingLabel)
        movieRatingLabel.layer.cornerRadius = 10
        movieRatingLabel.clipsToBounds = true
        movieRatingLabel.backgroundColor = Constants.yellowCustomColor
        movieRatingLabel.textColor = Constants.blackCustomColor
        movieRatingLabel.textAlignment = .center
        movieRatingLabel.font = UIFont(name: Constants.fontNameHelveticaBold, size: 15)
    }
    
    private func createMovieRatingLabelConstraint() {
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRatingLabel.centerYAnchor.constraint(equalTo: movieImageView.bottomAnchor).isActive = true
        movieRatingLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor).isActive = true
        movieRatingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        movieRatingLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createMovieImageView() {
        contentView.addSubview(movieImageView)
        movieImageView.layer.shadowColor = Constants.darkGrayCustomColor?.cgColor
        movieImageView.layer.shadowOffset = CGSize(width: -6, height: -6)
        movieImageView.layer.shadowOpacity = 10
        movieImageView.layer.shadowRadius = 6
        movieImageView.layer.masksToBounds = false
        movieImageView.contentMode = .scaleToFill
    }
    
    private func createMovieImageViewConstraint() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    private func createMovieTitleLabel() {
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.backgroundColor = Constants.grayCustomColor
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.layer.cornerRadius = 10
        movieTitleLabel.clipsToBounds = true
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.font = UIFont(name: Constants.fontNameAmericanTypewriterBold, size: 18)
    }
    
    private func createMovieTitleLabelConstraint() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        movieTitleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 20).isActive = true
        movieTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func createMovieOverviewLabel() {
        contentView.addSubview(movieOverviewLabel)
        movieOverviewLabel.backgroundColor = Constants.lightGrayCustomColor
        movieOverviewLabel.numberOfLines = 10
        movieOverviewLabel.layer.cornerRadius = 10
        movieOverviewLabel.clipsToBounds = true
        movieOverviewLabel.lineBreakMode = .byTruncatingTail
        movieOverviewLabel.textAlignment = .left
        movieOverviewLabel.padding(top: 0, bottom: 0, left: 10, right: 10)
        movieOverviewLabel.font = UIFont(name: Constants.fontNameAvenirBlack, size: 15)
    }
    
    private func createMovieOverviewLabelConstraint() {
        movieOverviewLabel.translatesAutoresizingMaskIntoConstraints = false
        movieOverviewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10).isActive = true
        movieOverviewLabel.centerXAnchor.constraint(equalTo: movieTitleLabel.centerXAnchor).isActive = true
        movieOverviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        movieOverviewLabel.widthAnchor.constraint(equalTo: movieTitleLabel.widthAnchor).isActive = true
    }
}

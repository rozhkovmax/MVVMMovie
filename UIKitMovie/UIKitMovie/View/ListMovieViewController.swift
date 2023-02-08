// ListMovieViewController.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Список фильмов
final class ListMovieViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let titleText = "Фильмы"
        static let identifierMovieCellID = "MovieCell"
        static let movieSegmentControlItems = ["В прокате", "Популярное", "Топ рейтинга"]
        static let fatalErrorText = "Критическая ошибка"
        static let backBarButtonItemName = "К списку"
        static let blackCustomColor = UIColor(named: "blackCustomColor")
        static let yellowCustomColor = UIColor(named: "yellowCustomColor")
        static let lightGrayCustomColor = UIColor(named: "lightGrayCustomColor")
        static let whiteCustomColor = UIColor(named: "whiteCustomColor")
        static let alertTitle = "Ошибка"
        static let alertActionTitle = "OK"
        static let alertMessageText = "Ошибка!"
    }

    // MARK: Private Visual Component

    private let movieSegmentControl = UISegmentedControl(items: Constants.movieSegmentControlItems)
    private let movieTableView = UITableView()
    private let movieActivityIndicatorView = UIActivityIndicatorView()

    // MARK: - Public Properties

    var listMovieViewModel: ListMovieViewModelProtocol?
    var onDetailMovieHandler: ((Movie) -> ())?
    var listMovieStates: ListMovieStates = .initial {
             didSet {
                 DispatchQueue.main.async {
                     self.view.setNeedsLayout()
                 }
             }
         }

    // MARK: - Initializers

    init(listMovieViewModel: ListMovieViewModelProtocol) {
        self.listMovieViewModel = listMovieViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }

    // MARK: - Public Methods

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        switch listMovieStates {
        case .initial:
            setupUI()
            movieActivityIndicatorView.startAnimating()
            movieActivityIndicatorView.isHidden = false
            movieTableView.isHidden = true
        case .success:
            movieTableView.isHidden = false
            movieActivityIndicatorView.isHidden = true
            movieActivityIndicatorView.stopAnimating()
            movieTableView.reloadData()
        case let .failure(error):
            showAlertController(error: error)
//        default:
//            showAlertController(alertTitle: Constants.alertTitle,
//                                alertMessage: Constants.alertMessageText,
//                                alertActionTitle: Constants.alertActionTitle,
//                                handler: nil)
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        setupListMovieStates()
//        setupNeedsLayout()
        createMovieSegmentControl()
        createMovieTableView()
        createVisualPresentation()
        createActivityIndicatorView()
        createMovieSegmentControlConstraint()
        createMovieTableViewConstraint()
        createActivityIndicatorViewConstraint()
        fetchMovies()
    }

    private func fetchMovies() {
        listMovieViewModel?.fetchMovies()
    }

    private func setupListMovieStates() {
        listMovieViewModel?.listMovieStates = { [weak self] state in
            self?.listMovieStates = state
        }
    }
    
//    private func setupNeedsLayout() {
//        listMovieViewModel?.layoutHandler = { [weak self] in
//            DispatchQueue.main.async {
//                self?.view.setNeedsLayout()
//            }
//        }
//    }

    private func createActivityIndicatorView() {
        movieTableView.addSubview(movieActivityIndicatorView)
        movieActivityIndicatorView.color = Constants.yellowCustomColor
    }

    private func createActivityIndicatorViewConstraint() {
        movieActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        movieActivityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieActivityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func createVisualPresentation() {
        title = Constants.titleText
        view.backgroundColor = Constants.blackCustomColor
        navigationController?.navigationBar.backgroundColor = Constants.blackCustomColor
        navigationController?.navigationBar
            .titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.yellowCustomColor as Any]
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: Constants.backBarButtonItemName,
            style: .plain,
            target: nil,
            action: nil
        )
    }

    private func createMovieSegmentControl() {
        view.addSubview(movieSegmentControl)
        movieSegmentControl.backgroundColor = Constants.lightGrayCustomColor
        movieSegmentControl.selectedSegmentTintColor = Constants.yellowCustomColor
        movieSegmentControl.selectedSegmentIndex = 0
        movieSegmentControl.addTarget(self, action: #selector(movieSegmentControlAction), for: .valueChanged)
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: Constants.whiteCustomColor]
        UISegmentedControl.appearance()
            .setTitleTextAttributes(titleTextAttributesNormal as [NSAttributedString.Key: Any], for: .normal)
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: Constants.blackCustomColor]
        UISegmentedControl.appearance()
            .setTitleTextAttributes(titleTextAttributesSelected as [NSAttributedString.Key: Any], for: .selected)
    }

    private func createMovieSegmentControlConstraint() {
        movieSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        movieSegmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        movieSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieSegmentControl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        movieSegmentControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func createMovieTableView() {
        view.addSubview(movieTableView)
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.backgroundColor = Constants.blackCustomColor
        movieTableView.register(ListMovieTableViewCell.self, forCellReuseIdentifier: Constants.identifierMovieCellID)
    }

    private func createMovieTableViewConstraint() {
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.topAnchor.constraint(equalTo: movieSegmentControl.bottomAnchor, constant: 20).isActive = true
        movieTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc private func movieSegmentControlAction(_ sender: UISegmentedControl) {
        listMovieViewModel?.segmentControlAction(index: sender.selectedSegmentIndex)
    }
}

/// Расширение для UITableViewDataSource, UITableViewDelegate
extension ListMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let moviesRow = listMovieViewModel?.movies else { return .zero }
        return moviesRow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listMovieViewModel = listMovieViewModel else { return UITableViewCell() }
        let cell = ListMovieTableViewCell(style: .default, reuseIdentifier: Constants.identifierMovieCellID)
        cell.configure(index: indexPath.row, listMovieViewModel: listMovieViewModel)
        cell.alertDelegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = listMovieViewModel?.movies[indexPath.row] else { return }
        onDetailMovieHandler?(movie)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree = 90.0
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

/// Расширение для вызова алерта
extension ListMovieViewController: AlertDelegate {
    func showAlertController(error: Error) {
        showAlertController(
            alertTitle: Constants.alertTitle,
            alertMessage: error.localizedDescription,
            alertActionTitle: Constants.alertActionTitle,
            handler: nil
        )
    }
}
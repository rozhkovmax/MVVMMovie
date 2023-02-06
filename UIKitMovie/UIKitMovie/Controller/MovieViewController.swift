// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контроллер представления списка фильмов
final class MovieViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let titleText = "Фильмы"
        static let indentifierMovieCell = "MovieCell"
        static let movieSegmentControlItems = ["В прокате", "Популярное", "Топ рейтинга"]
        static let errorText = "Ошибка"
        static let backBarButtonItemName = "К списку"
        static let blackCustomColor = UIColor(named: "blackCustomColor")
        static let yellowCustomColor = UIColor(named: "yellowCustomColor")
        static let lightGrayCustomColor = UIColor(named: "lightGrayCustomColor")
        static let whiteCustomColor = UIColor(named: "whiteCustomColor")
    }

    private enum CompleteQueryString {
        static let rentalQueryString =
            "https://api.themoviedb.org/3/movie/upcoming?api_key=b6abe1b1835ab9f0603050760032a03a&language=ru-RU&page=1"
        static let popularQueryString =
            "https://api.themoviedb.org/3/movie/popular?api_key=b6abe1b1835ab9f0603050760032a03a&language=ru-RU&page=1"
        static let topQueryString =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=b6abe1b1835ab9f0603050760032a03a&language=ru-RU&page=1"
    }

    // MARK: Private Visual Component

    private let movieSegmentControl = UISegmentedControl(items: Constants.movieSegmentControlItems)
    private let movieTableView = UITableView()
    private let movierefreshControl = UIRefreshControl()

    // MARK: - Private Properties

    private var movies: ResultsMovie?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        createMovieSegmentControl()
        createMovieTableView()
        createVisualPresentation()
        getMovies(CompleteQueryString.rentalQueryString)
        createRefreshControl()
        createMovieSegmentControlConstraint()
        createMovieTableViewConstraint()
    }

    private func createRefreshControl() {
        movieTableView.addSubview(movierefreshControl)
        movierefreshControl.addTarget(self, action: #selector(handleRefreshAction), for: .valueChanged)
        movierefreshControl.tintColor = Constants.yellowCustomColor
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

    private func getMovies(_ key: String) {
        guard let url = URL(string: key) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.movies = try decoder.decode(ResultsMovie.self, from: data)
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            } catch {
                print(Constants.errorText, error)
            }
        }.resume()
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
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.indentifierMovieCell)
    }

    private func createMovieTableViewConstraint() {
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.topAnchor.constraint(equalTo: movieSegmentControl.bottomAnchor, constant: 20).isActive = true
        movieTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc private func handleRefreshAction() {
        movierefreshControl.endRefreshing()
    }

    @objc private func movieSegmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getMovies(CompleteQueryString.rentalQueryString)
        case 1:
            getMovies(CompleteQueryString.popularQueryString)
        case 2:
            getMovies(CompleteQueryString.topQueryString)
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let moviesRow = movies?.movies else { return 0 }
        return moviesRow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.indentifierMovieCell,
            for: indexPath
        ) as? MovieTableViewCell else { return UITableViewCell() }
        guard let item = movies?.movies[indexPath.row] else { return UITableViewCell() }
        cell.refrashMovie(item)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movies?.movies[indexPath.row] else { return }
        let filmViewController = FilmViewController()
        filmViewController.film = movie
        navigationController?.pushViewController(filmViewController, animated: true)
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

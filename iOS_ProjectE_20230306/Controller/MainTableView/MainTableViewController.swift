//
//  ViewController.swift
//  iOS_ProjectE_20230306
//
//  Created by 백래훈 on 2023/03/06.
//

import UIKit

class MainTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier: String = "mainTableViewCell"
    var movies: [Movies] = []
    let url: String = "https://connect-boxoffice.run.goorm.io/movies"
    let orderType: String = "?order_type=0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXib()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        jsonDataLoad()
    }
    
    func jsonDataLoad() {
        guard let url: URL = URL(string: url + orderType) else { return }
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let movieInfo: MovieInfo = try JSONDecoder().decode(MovieInfo.self, from: data)
                self.movies = movieInfo.movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: cellIdentifier)
    }
}

extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        let movie: Movies = self.movies[indexPath.row]
        let grade: Int = movie.grade
        var viewingAgeData: String = ""
        
        cell.movieTitle?.text = movie.title
        cell.movieInfo?.text = movie.fullMovieInfo
        cell.movieReleaseDate?.text = movie.fullReleaseDate
        cell.movieImage?.image = nil
        cell.viewingAgeImage?.image = nil
        
        DispatchQueue.global().async {
            guard let thumbImageURL: URL = URL(string: movie.thumb) else { return }
            guard let thumbImageData: Data = try? Data(contentsOf: thumbImageURL) else { return }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.movieImage?.image = UIImage(data: thumbImageData)
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        switch grade {
        case 0:
            viewingAgeData = "ic_allages"
        case 12:
            viewingAgeData = "ic_12"
        case 15:
            viewingAgeData = "ic_15"
        case 19:
            viewingAgeData = "ic_19"
        default:
            viewingAgeData = "xmark"
        }
        
        DispatchQueue.main.async {
            cell.viewingAgeImage.image = UIImage(named: viewingAgeData)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

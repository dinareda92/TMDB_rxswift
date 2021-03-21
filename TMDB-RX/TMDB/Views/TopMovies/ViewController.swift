//
//  ViewController.swift
//  TMDB
//
//  Created by Dina Reda on 3/19/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
class ViewController: UIViewController , UITableViewDelegate{

    
    @IBOutlet weak var NoMovies_view: UIView!
    
    @IBOutlet weak var Movies_view: UIView!
    
    @IBOutlet weak var MoviesTableView: UITableView!
    
    let MovieCell = "MovieTableViewCell"
    let topMoviesViewModel = TopMoviesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MoviesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupMoviesTable()
        subscribeToLoading()
        subscribeToMoviesResponse()
        getMovies()
        subscribeToBranchSelection()
    }
 
    func setupMoviesTable()
    {
        MoviesTableView.register(UINib(nibName: MovieCell, bundle: nil), forCellReuseIdentifier: MovieCell)
    }
    func subscribeToLoading() {
        topMoviesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToMoviesResponse(){
        self.topMoviesViewModel.moviesModelObservable.bind(to: self.MoviesTableView.rx.items(cellIdentifier: MovieCell, cellType: MovieTableViewCell.self)){ row,movie,cell in
            
            let url = URL(string: "https://image.tmdb.org/t/p/w45" + movie.posterPath!)
            
            cell.movie_img.setImage(with: url!)
            cell.MovieName_lbl.text = movie.originalTitle!
            cell.MovieGenre_lbl.text = String(movie.voteAverage!) + "/10"
            
        }.disposed(by: disposeBag)
    }
    
    func subscribeToBranchSelection() {
            Observable
                .zip(MoviesTableView.rx.itemSelected, MoviesTableView.rx.modelSelected(Result.self))
                .bind { [weak self] selectedIndex, movie in
                    if let MovieDetailVC = UIStoryboard(name: "MovieDetailsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsView") as? MovieDetailsView {
                        MovieDetailVC.modalPresentationStyle = .fullScreen
                        MovieDetailVC.movieId = movie.id ?? 0
                        self?.present(MovieDetailVC, animated: true)
                                    }
                    print(selectedIndex, movie.originalTitle ?? "")
            }
            .disposed(by: disposeBag)
        }
    func getMovies(){
        self.topMoviesViewModel.getData()
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 87
    }
}

extension UIImageView {
    
    func setImage(with url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}

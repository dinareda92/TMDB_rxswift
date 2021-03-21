//
//  MovieDetailsView.swift
//  TMDB
//
//  Created by Dina Reda on 3/19/21.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsView: UIViewController {
    
    
    @IBOutlet weak var moviePoster_image: UIImageView!
    
    @IBOutlet weak var movieName_lbl: UILabel!
    
    @IBOutlet weak var movieAvgRate_lbl: UILabel!
    
    @IBOutlet weak var movieGenre_lbl: UILabel!
    
    
    @IBOutlet weak var movieRateCount_lbl: UILabel!
    
    @IBOutlet weak var movieLang_lbl: UILabel!
    
    @IBOutlet weak var movieReleaseDate_lbl: UILabel!
    

    @IBAction func BackAction(_ sender: Any) {
        if let MainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            MainVC.modalPresentationStyle = .fullScreen
           
            self.present(MainVC, animated: true)
                        }
    }
    
    @IBOutlet weak var naviga: UINavigationItem!
    var movieId : Int = 0
    let movieDetailsViewModel = MovieDetailsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToLoading()
        subscribeToMoviesResponse()
        getMovieDetailsById()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
                // Perform your custom actions
                // ...
                // Go back to the previous ViewController
                _ = navigationController?.popViewController(animated: true)
    }
    func subscribeToLoading() {
        movieDetailsViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    func subscribeToMoviesResponse(){
        self.movieDetailsViewModel.movieDetailsObservable.subscribe(onNext: {
            self.updateUI(movie: $0)

            
            
        }).disposed(by: disposeBag)
    }
    
    func updateUI(movie:MovieDetailsModel){
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + movie.posterPath!)
        self.moviePoster_image.setImage(with: url)
        self.movieName_lbl.text = movie.originalTitle
        self.movieLang_lbl.text = movie.originalLanguage
        let genre =  movie.genres![0]
        self.movieGenre_lbl.text = genre.name
        self.movieAvgRate_lbl.text = String(movie.voteAverage!) + "/10"
        self.movieRateCount_lbl.text =  String(movie.voteCount!)
        self.movieReleaseDate_lbl.text = movie.releaseDate
        self.naviga.title = movie.title
    }
    func getMovieDetailsById(){
        self.movieDetailsViewModel.getData(MovieId: movieId)
    }
}

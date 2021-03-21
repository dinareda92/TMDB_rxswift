//
//  MovieDetailsViewModel.swift
//  TMDB
//
//  Created by Dina Reda on 3/19/21.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class MovieDetailsViewModel{
    let appDelegate = UIApplication.shared.delegate as!AppDelegate
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var movieIdBehavior = BehaviorRelay<Int>(value: 0)
    
    private var movieDetailsModelSubject = PublishSubject<MovieDetailsModel>()
    
    var movieDetailsObservable : Observable<MovieDetailsModel>{
        return movieDetailsModelSubject
    }
    
    
    func getData(MovieId:Int){
        loadingBehavior.accept(true)
        MoviesServices.Shared.getData(url: "/movie/\(MovieId)?api_key=\(appDelegate.APIKey)&language=en-US", method: .get, params: nil, encoding: JSONEncoding.default, headers: nil) {[weak self]
            
            (movieDetailsModel:MovieDetailsModel?, errorModel:BaseErrorModel?, error) in
            
            guard let self = self else{return}
            self.loadingBehavior.accept(false)
            if let error = error{
                print(error.localizedDescription)
                
            }else if let errorModel = errorModel {
                print(errorModel.status_message ?? "Somthing went wrong")
            }else{
                guard let movieDetailsModel = movieDetailsModel  else {return}
               
                self.movieDetailsModelSubject.onNext(movieDetailsModel)
                
                
            }
            
        }
    }
}


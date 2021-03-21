//
//  TopMoviesViewModel.swift
//  TMDB
//
//  Created by Dina Reda on 3/19/21.
//

import Foundation

import RxSwift
import RxCocoa
import Alamofire

class TopMoviesViewModel{
    let appDelegate = UIApplication.shared.delegate as!AppDelegate
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var moviesModelSubject = PublishSubject<[Result]>()
    
    var moviesModelObservable : Observable<[Result]>{
        return moviesModelSubject
    }
    
    
    func getData(){
        loadingBehavior.accept(true)
        MoviesServices.Shared.getData(url: "/movie/top_rated?api_key=\(appDelegate.APIKey)&language=en-US&page=1", method: .get, params: nil, encoding: JSONEncoding.default, headers: nil) {[weak self]
            
            (topMoviesModel:TopMoviesModel?, errorModel:BaseErrorModel?, error) in
            
            guard let self = self else{return}
            self.loadingBehavior.accept(false)
            if let error = error{
                print(error.localizedDescription)
                
            }else if let errorModel = errorModel {
                print(errorModel.status_message ?? "Somthing went wrong")
            }else{
                guard let topMoviesModel = topMoviesModel  else {return}
                if topMoviesModel.results?.count ?? 0 > 0 {
                    self.moviesModelSubject.onNext(topMoviesModel.results ?? [])
                }
                
            }
            
        }
    }
}

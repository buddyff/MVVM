//
//  HomeViewModel.swift
//  MVVM
//
//  Created by rodrigo camparo on 9/15/19.
//  Copyright © 2019 rodrigo camparo. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class HomeViewModel {
    
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let albums: PublishSubject<[Album]> = PublishSubject()
    private let url = "https://gist.githubusercontent.com/mohammadZ74/dcd86ebedb5e519fd7b09b79dd4e4558/raw/b7505a54339f965413f5d9feb05b67fb7d0e464e/MvvmExampleApi.json"
    private let disposeBag = DisposeBag()
    
    public func requestData(){
        
        guard let url = URL(string: url) else { return }
        
        self.loading.onNext(true)
        
        RxAlamofire.data(.get, url, parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type": "application/x-www-form-urlencoded"])
            .subscribe(onNext: { [weak self] (data) -> Void in
                self?.loading.onNext(false)
                
                if let discography: Discography = JSONParser.decode(data) {
                    self?.albums.onNext(discography.albums)
                }
                
            }, onError: { [weak self] (error) in
                print("EERROR")
            })
            .disposed(by: disposeBag)
    }
}

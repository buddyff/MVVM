//
//  HomeViewController.swift
//  MVVM
//
//  Created by rodrigo camparo on 9/14/19.
//  Copyright © 2019 rodrigo camparo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {    

    @IBOutlet weak var albumCollection: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        homeViewModel.requestData()
    }
    
    private func setupViews() {
        albumCollection.register(UINib(nibName: "HorizontalCollectionCell", bundle: nil), forCellWithReuseIdentifier: String(describing: HorizontalCollectionCell.self))
    }
    
    private func setupBindings() {
        
        homeViewModel
            .loading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                $0 ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        
        homeViewModel
            .albums
            .bind(to: albumCollection.rx.items(cellIdentifier: "HorizontalCollectionCell", cellType: HorizontalCollectionCell.self)) {  (row,album,cell) in
                cell.album = album
                cell.withBackView = true
            }
            .disposed(by: disposeBag)
        
        
        albumCollection.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            }))
            .disposed(by: disposeBag)
    }
}

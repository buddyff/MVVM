//
//  HorizontalCollectionViewController.swift
//  MVVM
//
//  Created by rodrigo camparo on 9/14/19.
//  Copyright © 2019 rodrigo camparo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class HorizontalCollectionViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!    
    
    public var albums = PublishSubject<[Album]>()
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        collection.backgroundColor = .clear
    }
    
    
    
    private func setupBinding(){
        
        
        collection.register(UINib(nibName: "AlbumsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: AlbumsCollectionViewCell.self))
        
        
        albums.bind(to: albumsCollectionView.rx.items(cellIdentifier: "AlbumsCollectionViewCell", cellType: AlbumsCollectionViewCell.self)) {  (row,album,cell) in
            cell.album = album
            cell.withBackView = true
            }.disposed(by: disposeBag)
        
        
        
        
        collection.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
        
        
        
        
    }
    
}

//
//  AlbumPhotosViewController.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class AlbumPhotosViewController: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photosCollectionview: UICollectionView!
    
    //MARK: Properites
    var viewModel: AlbumsPhotosViewModelProtocol
    var albumName: String
    
    private let disposeBag = DisposeBag()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        subscribeToLoading()
        subscribeToError()
        bindCollectionViewToViewModel()
        bindSearchBarToViewModel()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
    
    //MARK: Initialzer
    init(albumName: String,
         viewModel: AlbumsPhotosViewModelProtocol) {
        self.albumName = albumName
        self.viewModel = viewModel
        super.init(nibName: "\(AlbumPhotosViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) hasn't been implemented")
    }
    
    //MARK: Deallocation
    deinit {
        debugPrint("\(AlbumPhotosViewController.self) release from memory")
    }
    
}

//MARK: Helper Funtions
extension AlbumPhotosViewController {
    private func setupNavigationController(){
        self.title = albumName
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupCollectionView(){
        photosCollectionview.register(cellWithClass: AlbumPhotoCell.self)
        photosCollectionview
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToLoading(){
        viewModel.loadingBehavior.subscribe { (isLoading) in
            if(isLoading){
                self.showIndicator()
            }else {
                self.hideIndicator()
            }
        }.disposed(by: disposeBag)
    }
    
    private func subscribeToError() {
        viewModel
            .errorObservable
            .bind
        { [weak self] error in
            guard let self = self else {return}
            self.showAlertController(title: "Error!",
                                     message: error.localizedDescription,
                                     actions: [])
        }.disposed(by: disposeBag)
    }
    
    private func bindCollectionViewToViewModel(){
        
        viewModel
            .filteredImagesModelBehavior
            .bind(to: photosCollectionview
                .rx
                .items(cellIdentifier: "\(AlbumPhotoCell.self)",
                       cellType: AlbumPhotoCell.self))
        { (row ,image ,cell) in
            
            guard let imageUrl = URL(string: image.url) else {return}
            cell.setImage(imageURL: imageUrl)
            
        }.disposed(by: disposeBag)
    }
    
    private func bindSearchBarToViewModel(){
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300),
                      scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] key in
                guard let self = self else {return}
                self.viewModel.searchKey.accept(key)
            }).disposed(by: disposeBag)
    }
}

//MARK: UISearchBarDelegate
extension AlbumPhotosViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension AlbumPhotosViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.photosCollectionview.frame.width/3 - 10
        return CGSize(width: width, height: width)
    }
}

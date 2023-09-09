//
//  ProfileTableViewController.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import UIKit
import RxSwift
import RxDataSources

class ProfileViewController: UIViewController {
    
    //MARK: OutLets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var viewModel: ProfileViewModelProtocol
    private let disposeBag = DisposeBag()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getUser()
        subscribeToLoading()
        subscribeToError()
        bindTableViewToViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    //MARK: Inintializer
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "\(ProfileViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) hasn't been implemented")
    }
    
    //MARK: Deallocation
    deinit {
        debugPrint("\(ProfileViewController.self) release from memory")
    }
    
}

//MARK: HelperFunctions
extension ProfileViewController {
    private func setupNavigationBar() {
        self.title = "Profile"
        guard let navigationController = self.navigationController else  {return}
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .black
    }
    
    private func setupTableView() {
        tableView.register(cellWithClass: UserDataCell.self)
        tableView.register(cellWithClass: UserAlbumCell.self)
    }
    
    private func subscribeToLoading() {
        viewModel
            .loadingBehavior
            .bind(onNext: { [weak self] (isLoading) in
                guard let self = self else {return}
                if(isLoading){
                    self.showIndicator()
                }else {
                    self.hideIndicator()
                }
            }).disposed(by: disposeBag)
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
    
    private func bindTableViewToViewModel() {
        
        viewModel.sectionsObservable
            .bind(to: tableView
                .rx
                .items(dataSource: createTableViewDataSource()))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SectionItem.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                switch item {
                case .album(let album):
                    self.navigateToAlbumPhotos(albumName: album.title,
                                               albumId: album.id)
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func navigateToAlbumPhotos(albumName: String,
                                       albumId: Int) {
        let albumPhotosRemoteDataManager = AlbumPhotosRemoteDataManager()
        let albumPhotosViewModel = AlbumPhotosViewModel(albumId: albumId,
                                                        albumPhotosRemoteDataManager: albumPhotosRemoteDataManager)
        let albumPhotosViewController = AlbumPhotosViewController(albumName: albumName,
                                                                  viewModel: albumPhotosViewModel)
        self.navigationController?.pushViewController(albumPhotosViewController,
                                                      animated: true)
    }
    
    
    private func createTableViewDataSource() -> RxTableViewSectionedReloadDataSource<Section> {
        return RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { (_, tableView, indexPath, item) in
                switch item {
                case .user(let user):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserDataCell.self)",
                                                                   for: indexPath) as? UserDataCell else { return UITableViewCell() }
                    let userAdrress = "\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
                    cell.configureCell(userName: user.name, userAddress: userAdrress)
                    return cell
                case .album(let album):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserAlbumCell.self)",
                                                                   for: indexPath) as? UserAlbumCell else { return UITableViewCell() }
                    cell.configureCell(albumName: album.title)
                    return cell
                }
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].title
            }
        )
    }
}

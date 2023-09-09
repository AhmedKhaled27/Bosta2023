//
//  ProfileViewModel.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct Section {
    var title: String?
    var items: [Item]
}

extension Section: SectionModelType {
    typealias Item = SectionItem

    init(original: Section, items: [Item]) {
        self = original
        self.items = items
    }
}

enum SectionItem {
    case user(User)
    case album(UserAlbum)
}

class ProfileViewModel: ProfileViewModelProtocol {

    //MARK: Properites
    var userRemoteDataManager: UsersRemoteDataManagerProtocol
    var userAlbumsRemoteDataManager: UserAlbumsRemoteDataManagerProtocol
    
    private let userResponseSubject = PublishSubject<User>()
    private let userAlbumsResponseSubject = PublishSubject<[UserAlbum]>()
    private let errorSubject = PublishSubject<Error>()
    private var userResponseObservable: Observable<User> {
        return userResponseSubject.asObservable()
    }
    private var userAlbumsResponse: Observable<[UserAlbum]> {
        return userAlbumsResponseSubject.asObservable()
    }
    
    var sectionsObservable: Observable<[Section]> {
        return Observable.combineLatest(userResponseObservable, userAlbumsResponse)
            .map { user, albums in
                // Create two sections, one for user data and one for albums data
                return [
                    Section(title: nil,
                            items: [SectionItem.user(user)]),
                    Section(title: "Albums",
                            items: albums.map { SectionItem.album($0) })
                ]
            }
    }
    var errorObservable: Observable<Error> {
        return errorSubject.asObservable()
    }
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    //MARK: Inintailzer
    init(userRemoteDataManager: UsersRemoteDataManagerProtocol,
         userAlbumsRemoteDataManager: UserAlbumsRemoteDataManagerProtocol) {
        self.userRemoteDataManager = userRemoteDataManager
        self.userAlbumsRemoteDataManager = userAlbumsRemoteDataManager
    }
    
    //MARK: Deallocation
    deinit {
        debugPrint("\(ProfileViewModel.self) release from memory")
    }
}

//MARK: Helper Functions
extension ProfileViewModel {
    func getUser() {
        loadingBehavior.accept(true)
        userRemoteDataManager
            .getUsersData()
            .subscribe(onNext: { [weak self] user in
                guard let self = self else {return}
                self.loadingBehavior.accept(false)
                self.userResponseSubject.onNext(user)
                self.getUserAlbums(userId: user.id)
            },
            onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingBehavior.accept(false)
                debugPrint("\(error.localizedDescription)")
                self.errorSubject.onNext(error)
            }).disposed(by: disposeBag)
    }
        
    private func getUserAlbums(userId:Int) {
        loadingBehavior.accept(true)
        userAlbumsRemoteDataManager
            .getUserAlbums(userId: userId)
            .subscribe(onNext: { [weak self] userAbums in
                guard let self = self else {return}
                self.loadingBehavior.accept(false)
                self.userAlbumsResponseSubject.onNext(userAbums)
            },
            onError: { [weak self] error in
                guard let self = self else {return}
                self.loadingBehavior.accept(false)
                self.errorSubject.onNext(error)
            }).disposed(by: disposeBag)
    }
}

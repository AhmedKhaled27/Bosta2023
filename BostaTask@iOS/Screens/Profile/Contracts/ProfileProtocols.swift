//
//  ProfileProtocols.swift
//  Bosta2023
//
//  Created by Ahmed Khaled on 08/09/2023.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: ViewModel
protocol ProfileViewModelProtocol {
    //Properites
    var sectionsObservable: Observable<[Section]> {get}
    var errorObservable: Observable<Error> {get}
    var loadingBehavior: BehaviorRelay<Bool> {get set}
    
    //Functions
    func getUser()
}

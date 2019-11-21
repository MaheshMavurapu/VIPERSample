//
//  PostsDetailPresenter.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation

protocol PostDetailPresenterProtocol: class {
    var view: PostDetailViewProtocol? { get set }
    var router: PostDetailRouterProtocol? { get set }
    var post: PostsModel? { get set }
    // VIEW -> PRESENTER
    func viewDidLoad()
}

class PostsDetailPresenter: PostDetailPresenterProtocol {
    
    weak var view: PostDetailViewProtocol?
    var router: PostDetailRouterProtocol?
    var post: PostsModel?
    
    func viewDidLoad() {
        view?.showPostDetail(forPost: post!)
    }
}

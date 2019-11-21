//
//  PostsListPresenter.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation
import UIKit

protocol PostListPresenterProtocol: class {
    var view: PostListViewProtocol? { get set }
    var interactor: PostListInteractorInputProtocol? { get set }
    var router: PostListRouterProtocol? { get set }
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showPostDetail(forPost post: PostsModel)
}

class PostsListPresenter: PostListPresenterProtocol {
    weak var view: PostListViewProtocol?
    var interactor: PostListInteractorInputProtocol?
    var router: PostListRouterProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrievePostList()
    }
    
    func showPostDetail(forPost post: PostsModel) {
        router?.presentPostDetailScreen(from: view!, forPost: post)
    }
}

extension PostsListPresenter: PostListInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: [PostsModel]) {
        view?.hideLoading()
        view?.showPosts(with: posts)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}

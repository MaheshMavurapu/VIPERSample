//
//  PostsListRouter.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation
import UIKit

protocol PostListRouterProtocol: class {
    static func createPostListModule() -> UIViewController
    // PRESENTER -> Router
    func presentPostDetailScreen(from view: PostListViewProtocol, forPost post: PostsModel)
}

class PostsListRouter: PostListRouterProtocol {
    
    class func createPostListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PostsNavigationController")
        if let view = navController.children.first as? PostsListViewController {
            let presenter: PostListPresenterProtocol & PostListInteractorOutputProtocol = PostsListPresenter()
            let interactor: PostListInteractorInputProtocol & PostListRemoteDataManagerOutputProtocol = PostsListInteractor()
            let localDataManager: PostListLocalDataManagerInputProtocol = PostsListLocalDataManager()
            let remoteDataManager: PostListRemoteDataManagerInputProtocol = PostsListRemoteDataManager()
            let router: PostListRouterProtocol = PostsListRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentPostDetailScreen(from view: PostListViewProtocol, forPost post: PostsModel) {
        let postDetailViewController = PostsDetailRouter.createPostDetailModule(forPost: post)
        if let sourceView = view as? UIViewController {
           sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
}

//
//  PostsDetailRouter.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation
import UIKit

protocol PostDetailRouterProtocol: class {
    static func createPostDetailModule(forPost post: PostsModel) -> UIViewController
}

class PostsDetailRouter: PostDetailRouterProtocol {
    
    class func createPostDetailModule(forPost post: PostsModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PostsDetailViewController")
        if let view = viewController as? PostsDetailViewController {
            let presenter: PostDetailPresenterProtocol = PostsDetailPresenter()
            let router: PostDetailRouterProtocol = PostsDetailRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.post = post
            presenter.router = router
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

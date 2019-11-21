//
//  PostsListInteractor.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation
import UIKit

protocol PostListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [PostsModel])
    func onError()
}

protocol PostListInteractorInputProtocol: class {
    var presenter: PostListInteractorOutputProtocol? { get set }
    var localDatamanager: PostListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: PostListRemoteDataManagerInputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func retrievePostList()
}

class PostsListInteractor: PostListInteractorInputProtocol {
    weak var presenter: PostListInteractorOutputProtocol?
    var localDatamanager: PostListLocalDataManagerInputProtocol?
    var remoteDatamanager: PostListRemoteDataManagerInputProtocol?
    
    func retrievePostList() {
        do {
            if let postList = try localDatamanager?.retrievePostList() {
                let PostsModelList = postList.map() {
                    return PostsModel(id: Int($0.id), title: $0.title!, imageUrl: $0.imageUrl!, thumbImageUrl: $0.thumbImageUrl!)
                }
                if  PostsModelList.isEmpty {
                    remoteDatamanager?.retrievePostList()
                }else{
                   presenter?.didRetrievePosts(PostsModelList)
                }
            } else {
                remoteDatamanager?.retrievePostList()
            }
            
        } catch {
            presenter?.didRetrievePosts([])
        }
    }
}

extension PostsListInteractor: PostListRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [PostsModel]) {
        presenter?.didRetrievePosts(posts)
        
        for post in posts {
            do {
                try localDatamanager?.savePost(id: post.id, title: post.title, imageUrl: post.imageUrl, thumbImageUrl: post.thumbImageUrl)
            } catch  {
                
            }
        }
    }
    
    func onError() {
        presenter?.onError()
    }
}

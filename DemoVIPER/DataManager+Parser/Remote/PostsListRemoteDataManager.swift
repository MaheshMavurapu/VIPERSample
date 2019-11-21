//
//  PostsListRemoteDataManager.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class PostsListRemoteDataManager: PostListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        Alamofire
            .request(Endpoints.Posts.fetch.url, method: .get)
            .validate()
            .responseArray(completionHandler: { (response: DataResponse<[PostsModel]>) in
                switch response.result {
                case .success(let posts):
                    self.remoteRequestHandler?.onPostsRetrieved(posts)
            
                case .failure( _):
                    self.remoteRequestHandler?.onError()
                }
            })
    }
}

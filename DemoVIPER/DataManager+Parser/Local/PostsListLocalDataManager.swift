//
//  PostsListLocalDataManager.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation
import CoreData

class PostsListLocalDataManager: PostListLocalDataManagerInputProtocol {
    
    func retrievePostList() throws -> [Post]  {
        
        guard let managedOC = CoreDataStore.sharedManager.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Post> = NSFetchRequest(entityName: String(describing: Post.self))
        
        return try managedOC.fetch(request)
    }
    
    func savePost(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws {
        guard let managedOC = CoreDataStore.sharedManager.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newPost = NSEntityDescription.entity(forEntityName: "Post",
                                                           in: managedOC) {
            let post = Post(entity: newPost, insertInto: managedOC)
            post.id = Int32(id)
            post.title = title
            post.imageUrl = imageUrl
            post.thumbImageUrl = thumbImageUrl
            try managedOC.save()
        }
        throw PersistenceError.couldNotSaveObject
    }
}

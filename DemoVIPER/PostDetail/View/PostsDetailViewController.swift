//
//  PostsDetailViewController.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import UIKit
import AlamofireImage

protocol PostDetailViewProtocol: class {
    var presenter: PostDetailPresenterProtocol? { get set }
    // PRESENTER -> VIEW
    func showPostDetail(forPost post: PostsModel)
}

class PostsDetailViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var presenter: PostDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension PostsDetailViewController: PostDetailViewProtocol {
    
    func showPostDetail(forPost post: PostsModel) {
        titleLabel?.text = post.title
        let url = URL(string: post.imageUrl)!
        let placeholderImage = UIImage(named: "placeholder")!
        postImageView?.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}

//
//  PostsListViewController.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import UIKit
import PKHUD

protocol PostListViewProtocol: class {
    var presenter: PostListPresenterProtocol? { get set }
    // PRESENTER -> VIEW
    func showPosts(with posts: [PostsModel])
    func showError()
    func showLoading()
    func hideLoading()
}

class PostsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: PostListPresenterProtocol?
    var postList: [PostsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
}

extension PostsListViewController: PostListViewProtocol {
    
    func showPosts(with posts: [PostsModel]) {
        postList = posts
        tableView.reloadData()
    }
    
    func showError() {
        HUD.flash(.label("Internet not connected"), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
}

extension PostsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsListTableViewCell", for: indexPath) as! PostsListTableViewCell
        
        let post = postList[indexPath.row]
        cell.set(forPost: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showPostDetail(forPost: postList[indexPath.row])
    }
}

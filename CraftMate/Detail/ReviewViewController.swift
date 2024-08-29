//
//  ReviewViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/28/24.
//

import UIKit

final class ReviewViewController: BaseViewController<ReviewView> {
    
    var post: Post?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostDetails()
    }
    
    func fetchPostDetails() {
        if let post {
            NetworkManager.shared.fetchPostDetails(postId: post.postId) { post in
                self.post = post
                DispatchQueue.main.async {
                    print("reload")
                    self.rootView.tableView.reloadData()
                }
            }
        }
    
    }
    
    override func setupAddTarget() {
        rootView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc func sendButtonTapped() {
        self.fetchPostDetails()
        rootView.textField.text = ""
    }
    
    override func configureView() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        rootView.tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
        
        rootView.tableView.rowHeight = 80

        rootView.textField.delegate = self
    }
    
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comments = post?.comments else { return 0 }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        if let review = post?.comments?[indexPath.row] {
            cell.configureCell(review)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if let post {
                if let comments = post.comments {
                    NetworkManager.shared.commentsDelete(postID: post.postId, commentID: comments[indexPath.row].content)
                    fetchPostDetails()
                    print("삭제")
                }
            }
//
//            self.post?.comments?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
    
    
    
}

extension ReviewViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, let post {
            NetworkManager.shared.writeComments(comments: text, postid: post.postId)
            self.fetchPostDetails()
            
            textField.text = ""  // 전송 후 텍스트 필드 초기화
        }
        return true
    }
}

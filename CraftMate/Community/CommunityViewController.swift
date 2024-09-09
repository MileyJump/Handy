//
//  CommunityViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//
//
//  CommunityViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//
import UIKit
import RxSwift
import RxCocoa

final class CommunityViewController: BaseViewController<CommunityView> {

    private let viewModel = CommunityViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    override func setupUI() {
        rootView.tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        rootView.tableView.allowsSelection = false
        rootView.tableView.delegate = self
    }

    override func setupNavigationBar() {
        navigationItem.title = "커뮤니티"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.white

        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: CraftMate.color.blackColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
    }

    private func bindViewModel() {
        // Input 생성: 화면이 나타날 때와 버튼 클릭 이벤트
        let input = CommunityViewModel.CommunityInput(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:)))
                .map { _ in } // 매개변수로 넘어오는 값은 무시하고 빈 값 방출
                .asObservable(),
            floatingButtonTapped: rootView.floatingButton.floatingButton.rx.tap.asObservable(),
            ellipsisButtonTapped: PublishSubject<Int>().asObservable(),
            commentsViewButtonTapped: PublishSubject<Void>().asObservable()
        )

        // ViewModel에서 변환된 Output을 받아옴
        let output = viewModel.transform(input: input)

        // posts 데이터를 테이블 뷰에 바인딩
        output.posts
            .observe(on: MainScheduler.instance)  // UI 작업은 메인 스레드에서 처리해야 함
            .bind(to: rootView.tableView.rx.items(cellIdentifier: CommunityTableViewCell.identifier, cellType: CommunityTableViewCell.self)) { [weak self] (row: Int, post: Post, cell: CommunityTableViewCell) in
                guard let self = self else { return }
                cell.configureCell(with: post)
                print("--------")
                print(post)  // 데이터를 확인하기 위한 print문
                print("--------")

                cell.commentsViewButton.rx.tap
                    .bind { [weak self] in
                        guard let self = self else { return }
                        self.viewModel.onCommentsViewButtonTapped()
                    }
                    .disposed(by: cell.disposeBag)

                cell.ellipsisButton.rx.tap
                    .bind { [weak self] in
                        guard let self = self else { return }
                        self.viewModel.onEllipsisButtonTapped(row: row)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)

        // 에러 메시지를 받아서 경고창으로 표시
        output.error
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] error in
                self?.showAlert(message: error)
            })
            .disposed(by: disposeBag)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension CommunityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 560 // 셀의 높이 설정
    }
}

//final class CommunityViewController: BaseViewController<CommunityView> {
//
//    private var nextCursor: String? // 다음 페이지를 위한 커서
//    private var isFetching: Bool = false // 중복 요청 방지
//    
//    var postList: [Post] = []
//    
//    var selectedIndex: Int = 0
//    
//    private let disposeBag = DisposeBag()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bind()
//        fetchAllPosts(cursor: nil)
//    }
//    
//    override func setupUI() {
//
//        rootView.tableView.delegate = self
//        rootView.tableView.dataSource = self
////        rootView.tableView.prefetchDataSource = self
//        
//        rootView.tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
//        
//        rootView.tableView.allowsSelection = false
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        fetchPosts()
//        
//    }
//    
//    override func setupNavigationBar() {
//        navigationItem.title = "커뮤니티"
//        view.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = UIColor.white // 원하는 배경 색상으로 설정
//        
//        // 네비게이션 바 타이틀 색상 및 폰트 설정
//        navigationController?.navigationBar.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: CraftMate.color.blackColor, // 원하는 타이틀 색상으로 설정
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold) // 원하는 폰트 설정
//        ]
//    }
//    
//    
//    func fetchAllPosts(cursor: String?) {
//        guard !isFetching else { return } // 중복 요청 방지
//        isFetching = true
//        
//        let query = FetchPostQuery(next: cursor, limit: "20", product_id: "커뮤니티")
//        NetworkManager.shared.fetchPost(query: query) { [weak self] result, error in
//            guard let self = self else { return }
//            self.isFetching = false
//            
//            if let result = result {
//                self.postList.append(contentsOf: result.data)
//                self.nextCursor = result.nextCursor // 다음 페이지를 위한 커서 업데이트
//                self.rootView.tableView.reloadData()
//            } else {
//                print("Error: \(String(describing: error))")
//            }
//        }
//    }
//    
//    func bind() {
//        rootView.floatingButton.floatingButton
//            .rx
//            .tap
//            .bind(with: self) { owner, _ in
//                let vc = CommunityCreatViewController()
//                let naviVc = UINavigationController(rootViewController: vc)
//                naviVc.modalPresentationStyle = .fullScreen
//                owner.present(naviVc, animated: true)
//                
//            }
//            .disposed(by: disposeBag)
//
//    }
//    
//    @objc func commentsViewButtonTapped() {
//        let vc = ReviewViewController()
////        vc.post = postList
//        present(vc, animated: true)
//    }
//    
//    @objc func ellipsisButtonTapped(_ sender: UIButton) {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        let edit = UIAlertAction(title: "게시글 수정", style: .default) { _ in
//            self.editButtonTapped()
//            
//        }
//        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
//            self.deleteButtonTapped(sender.tag)
//        }
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        
//
//        alert.addAction(cancel)
//        alert.addAction(edit)
//        alert.addAction(delete)
//
//        present(alert, animated: true)
//        
//        
//    }
//    
//    func editButtonTapped() {
//        
//    }
//    
//    func deleteButtonTapped(_ tag: Int) {
//        NetworkManager.shared.deletePost(postId: postList[tag].postId)
//    }
//    
////    func scrollToSeletedPost() {
////        print(#function)
////        let indexPath = IndexPath(row: selectedIndex, section: 0)
////        
////        rootView.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
////    }
//    
//    override func configureView() {
//    
//    }
//    
//}
//
//extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return postList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.identifier, for: indexPath) as? CommunityTableViewCell else {
//             return UITableViewCell() }
//        cell.configureCell(with: postList[indexPath.row])
//        cell.commentsViewButton.addTarget(self, action: #selector(commentsViewButtonTapped), for: .touchUpInside)
//        cell.commentsButton.addTarget(self, action: #selector(commentsViewButtonTapped), for: .touchUpInside)
//        cell.ellipsisButton.tag = indexPath.row
//        cell.ellipsisButton.addTarget(self, action: #selector(ellipsisButtonTapped), for: .touchUpInside)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 560
//    }
//}
//extension CommunityViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        guard let maxIndex = indexPaths.map({ $0.row }).max() else { return }
//           
//           // 현재 postList의 마지막 항목에 근접한 경우 추가 데이터를 로드
//           if maxIndex >= postList.count - 1 {
//               fetchAllPosts(cursor: nextCursor)
//           }
//    }
//}
//

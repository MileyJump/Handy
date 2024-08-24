//
//  HomeController.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//
import UIKit
//import RxSwift
//import RxCocoa
import Tabman
import Pageboy

final class HomeViewController: TabmanViewController {
    
    //   let disposeBag = DisposeBag()
    
    var items = ["홈", "구매"]
    
    // 탭을 통해 보여줄 뷰 컨트롤러들
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 각 탭에 연결될 ViewController들을 초기화
        setupViewControllers()
        
        // PageboyViewController의 데이터 소스를 self로 설정
        self.dataSource = self
        
        // Tabman의 탭 바 설정
        setupTabBar()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        
        let search = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.searchImage), style: .plain, target: nil, action: nil)
        //let shoppingBag = UIBarButtonItem(image: UIImage(named: "쇼핑백"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [search]
        
        navigationItem.title = "CraftMate"
        if let font = CraftMate.CustomFont.SemiBold20 {
            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.mainColor)
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    private func setupViewControllers() {
     
        let homeVC = HomeContentViewController()
        let orderVC = OrderViewController()
        
        viewControllers = [homeVC, orderVC] // 각 탭에 연결될 뷰 컨트롤러 추가
    }
    
    private func setupTabBar() {
        let bar = TMBar.ButtonBar()
        
        let systemBar = bar.systemBar()
        
        bar.layout.contentMode = .fit
        
        bar.backgroundColor = .white
        
        bar.layout.transitionStyle = .snap
        
        bar.buttons.customize { button in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.font = CraftMate.CustomFont.bold14 ?? UIFont.boldSystemFont(ofSize: 14)
            button.backgroundColor = .white
        }
        
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        bar.indicator.tintColor = .black
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    
}

extension HomeViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: items[index])  // 탭의 제목 설정
    }
}



//import UIKit
//import RxSwift
//import RxCocoa
//import Tabman
//
//final class HomeViewController: BaseViewController<HomeView> {
//
//    let disposeBag = DisposeBag()
//    let viewModel = HomeViewModel()
//
//    // 나중에 Rx로 수정
//    var items = ["홈데코", "공예", "리폼", "아이들", "주방", "기타"]
//    var images = ["홈", "비즈", "비즈", "홈", "주방", "비즈" ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        rootView.tableView.delegate = self
//        rootView.collectionView.delegate = self
//        rootView.collectionView.dataSource = self
//        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
//
//        // 네트워크 요청 실행
//        viewModel.fetchPosts()
//
//        bindTableView()
//        bind()
//    }
//
//    func bind() {
//        rootView.floatingButton.floatingButton
//            .rx
//            .tap
//            .bind(with: self) { owner, _ in
//                owner.navigationController?.pushViewController(WritePostViewController(), animated: true)
//            }
//            .disposed(by: disposeBag)
//
//        // 수정하기..
//        rootView.segmentControl.rx.selectedSegmentIndex
//            .bind(with: self, onNext: { owner, index in
//              owner.rootView.updateSelectionIndicatorPosition(for: index)
//                print(index)
//
//
//            })
//            .disposed(by: disposeBag)
//    }
//
//    func bindTableView() {
//        // ViewModel의 posts와 TableView 바인딩
//        viewModel.posts
//            .bind(to: rootView.tableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { row, post, cell in
//                cell.configure(with: post)
//            }
//            .disposed(by: disposeBag)
//    }
//
//    override func setupNavigationBar() {
//        let search = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.searchImage), style: .plain, target: nil, action: nil)
//        let shoppingBag = UIBarButtonItem(image: UIImage(named: "쇼핑백"), style: .plain, target: nil, action: nil)
//
//        navigationItem.rightBarButtonItems = [search]
//
//        navigationItem.title = "CraftMate"
//        if let font = CraftMate.CustomFont.SemiBold20 {
//            navigationController?.navigationBar.configureNavigationBarTitle(font: font, textColor: CraftMate.color.mainColor)
//        }
//
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//    }
//
//     func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        } else {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
//}
//
//
//
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        cell.configureCell(title: items[indexPath.row], image: images[indexPath.row])
//
//
//        return cell
//    }
//
//
//}
//
//extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let selectedPost = viewModel.posts.value[indexPath.row]
//        // 선택된 포스트에 대한 처리 추가
//    }
//}
//
//

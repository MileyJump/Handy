//
//  HomeContentViewController.swift
//  CraftMate
//
//  Created by 최민경 on 8/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeContentViewController: BaseViewController<HomeView> {
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
        viewModel.fetchInitialPosts()
    }
    
    override func configureView() {
        view.backgroundColor = .white
        
        rootView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        rootView.orderCollectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.identifier)
        
        rootView.collectionView.delegate = nil
        rootView.orderCollectionView.delegate = nil
    }
    
        override func setupNavigationBar() {
       
            let search = UIBarButtonItem(image: UIImage(systemName: CraftMate.Phrase.searchImage), style: .plain, target: nil, action: nil)
            
            navigationItem.rightBarButtonItems = [search]
            
            navigationItem.title = CraftMate.Phrase.serviceName

    
            let customFont = UIFont(name: "UhBee Se_hyun Bold", size: 27) ?? UIFont.systemFont(ofSize: 24)
            
            self.navigationController?.navigationBar.titleTextAttributes = [
                  NSAttributedString.Key.font: customFont,
                  NSAttributedString.Key.foregroundColor: CraftMate.color.mainColor // 타이틀 색상 설정 (옵션)
              ]
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            
            search.rx.tap
                .bind(with: self) { owner, _ in
                    let vc = SearchPageViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                }
                .disposed(by: disposeBag)
        }
    

    
    func bind() {
        let prefetchRows = rootView.orderCollectionView.rx.prefetchItems.asObservable()
        let categoryChanged = PublishSubject<String>()

        // 초기 데이터 로딩을 위한 카테고리 설정
        categoryChanged.onNext(viewModel.items.first ?? "홈데코")

        let input = HomeViewModel.Input(
            floatingButtonTap: rootView.floatingButton.floatingButton.rx.tap,
            searchButtonTap: navigationItem.rightBarButtonItems?.first?.rx.tap ?? ControlEvent(events: Observable.empty()),
            orderItemSelected: rootView.orderCollectionView.rx.itemSelected,
            categoryItemSelected: rootView.collectionView.rx.itemSelected,
            prefetchRows: prefetchRows,
            categoryChanged: categoryChanged.asObservable()
        )

        let output = viewModel.transform(input: input)

        // Bind outputs
        output.floatingScreenTrigger
            .observe(on: MainScheduler.instance)
            .bind(with: self, onNext: { owner, _ in
                let vc = WritePostViewController()
                let naviVc = UINavigationController(rootViewController: vc)
                naviVc.modalPresentationStyle = .fullScreen
                owner.present(naviVc, animated: true)
            })
            .disposed(by: disposeBag)

        output.searchScreenTrigger
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let vc = SearchPageViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        output.selectedPost
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (post: Post) in
                let vc = DetailViewController()
                vc.postSubject.onNext(post)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        output.selectedCategory
            .bind(to: categoryChanged)
            .disposed(by: disposeBag)

        output.posts
            .observe(on: MainScheduler.instance)
            .bind(to: rootView.orderCollectionView.rx.items(cellIdentifier: OrderCollectionViewCell.identifier, cellType: OrderCollectionViewCell.self)) { (row: Int, post: Post, cell: OrderCollectionViewCell) in
                cell.configureCell(data: post)
                print(post)
            }
            .disposed(by: disposeBag)

        output.fetchPostsError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                print("Error fetching posts: \(error)")
            })
            .disposed(by: disposeBag)

        // 카테고리 CollectionView 바인딩
        Observable.just(viewModel.items)
            .bind(to: rootView.collectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)) { row, element, cell in
                cell.configureCell(title: element, image: self.viewModel.sortImages[row])
            }
            .disposed(by: disposeBag)

        // Set up RxCocoa delegates
        rootView.orderCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        rootView.collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension HomeContentViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView)
        if translation.y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

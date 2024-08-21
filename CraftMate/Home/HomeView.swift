//
//  HomeView.swift
//  CraftMate
//
//  Created by 최민경 on 8/16/24.
//
import UIKit
import SnapKit

final class HomeView: BaseView {

    let segmentControl = UISegmentedControl(items: ["홈", "구매"]).then {
        $0.selectedSegmentIndex = 0
        
        // 배경을 투명하게 설정
        $0.backgroundColor = .clear
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        // 텍스트 색상 설정
        $0.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
    // 선택된 세그먼트 아래에 검은 줄을 표시할 뷰
    let selectionIndicator = UIView().then {
        $0.backgroundColor = UIColor.black
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.itemCollectionViewLayout())
    
    let tableView = UITableView()
    
    let floatingButton = FloatingButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func configureHierarchy() {
        addSubview(segmentControl)
        addSubview(selectionIndicator)
        addSubview(collectionView)
        addSubview(tableView)
        addSubview(floatingButton)
        
        
    }
    
    override func configureLayout() {
        segmentControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        selectionIndicator.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.height.equalTo(2)  // 검은 줄의 높이
            make.width.equalTo(segmentControl.snp.width).dividedBy(segmentControl.numberOfSegments)
            make.leading.equalTo(segmentControl.snp.leading)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(selectionIndicator.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(2)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.size.equalTo(60)
        }
    }
    
    override func configureView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.rowHeight = 400
    }
    
    func updateSelectionIndicatorPosition(for selectedIndex: Int) {
        let segmentWidth = segmentControl.bounds.width / CGFloat(segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * CGFloat(selectedIndex)
        
        selectionIndicator.snp.updateConstraints { make in
            make.leading.equalTo(segmentControl.snp.leading).offset(leadingDistance)
        }
        
        // 애니메이션으로 줄의 이동을 더 부드럽게 만듦
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

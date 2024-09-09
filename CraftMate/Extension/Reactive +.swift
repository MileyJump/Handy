//
//  Reactive +.swift
//  CraftMate
//
//  Created by 최민경 on 9/9/24.
//

import UIKit
import RxSwift
import RxCocoa

// `UIBarButtonItem`에 `rx.tap`을 추가하는 확장
extension Reactive where Base: UIBarButtonItem {
    var tap: ControlEvent<Void> {
        let source = Observable<Void>.create { observer in
            let target = UIBarButtonItemTarget { _ in
                observer.onNext(())
            }
            self.base.target = target
            self.base.action = #selector(target.invoke)
            return Disposables.create {
                self.base.target = nil
                self.base.action = nil
            }
        }
        return ControlEvent(events: source)
    }
}

// `UIBarButtonItem`의 `target`과 `action`을 감싸주는 helper 클래스
private final class UIBarButtonItemTarget: NSObject {
    private let action: (UIBarButtonItem) -> Void

    init(action: @escaping (UIBarButtonItem) -> Void) {
        self.action = action
    }

    @objc func invoke(_ sender: UIBarButtonItem) {
        action(sender)
    }
}

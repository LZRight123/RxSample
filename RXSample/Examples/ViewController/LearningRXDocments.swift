//
//  LearningRXDocments.swift
//  RXSample
//
//  Created by liangze on 2019/9/7.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
import RxSwift

struct Model {
    let title: String
    let event: () -> Void
}

class LearningRXDocments: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "RXDocuments"
       
    
        let dataSource = [
            Model(title: "共享附加作用 Request", event: { self.testShare() }),
            Model(title: "不共享附加作用 Request", event: { self.testNoShare() }),
            
            Model(title: "下面是文档上的 Observable", event: { }),
            Model(title: "observable", event: { self.observable() }),
            Model(title: "single 不共享附加作用 不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。", event: { self.single() }),
            Model(title: "completable 不共享附加作用 不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。", event: { self.completable() }),
            Model(title: "maybe 不共享附加作用 Maybe 是 Observable 的另外一个版本 它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。", event: { self.maybe() }),
            Model(title: "driver 共享附加作用 不会产生 error 事件,一定在 MainScheduler 监听（主线程监听）", event: { self.driver() }),
            Model(title: "signal 共享附加作用 Signal 和 Driver 相似，唯一的区别是，Driver 会对新观察者回放（重新发送）上一个元素，而 Signal 不会对新观察者回放上一个元素。", event: { self.signal() }),

            Model(title: "下面是文档上的 Observable & Observer 既是可监听序列也是观察者", event: { }),
            Model(title: "asyncSubject 在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件。", event: { self.asyncSubject() }),
            Model(title: "publishSubject 而在订阅前发出的元素将不会发送给观察者。如果你希望观察者接收到所有的元素，你可以通过使用 Observable 的 create 方法来创建 Observable，或者使用 ReplaySubject。", event: { self.publishSubject() }),
            Model(title: "replaySubject 将对观察者发送全部的元素，无论观察者是何时进行订阅的。", event: { self.replaySubject() }),
            Model(title: "behaviorSubject 当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来。", event: { self.behaviorSubject() }),
            Model(title: "PublishRelay 和 BehaviorRelay 就是对应的Subject 去掉终止事件 onError 或 onCompleted。用accept接受事件元素", event: { }),
        ]
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        Observable<[Model]>.just(dataSource)
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { (row, element, cell) in
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = element.title
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Model.self)
            .subscribe(onNext: { (model) in
                model.event()
            })
            .disposed(by: disposeBag)
    }


}


extension LearningRXDocments {
    private func testShare() {
        //driver is share
        let ob =  FristService.originGetPlayList(1)
            .map{ arr -> [SongModel] in
                print("Driver")
                return arr
        }
        
        ob.drive(onNext: { (ar) in
            
        }).disposed(by: self.disposeBag)
        
        ob.drive(onNext: { (ar) in
            
        }).disposed(by: self.disposeBag)
        
        ob.drive(onNext: { (ar) in
            
        }).disposed(by: self.disposeBag)
    }
    
    private func testNoShare(){
        //Single is no share
        let ob = fmProvider.rx.request(.playlist(index: 0))
            .mapArray(SongModel.self, atKeyPath: "song")
            .map{ arr -> [SongModel] in
                print("Single")
                return arr
        }
        
        ob.subscribe(onSuccess: { (ar) in
            
        }).disposed(by: self.disposeBag)
        
        ob.subscribe(onSuccess: { (ar) in
            
        }).disposed(by: self.disposeBag)
        
        ob.subscribe(onSuccess: { (ar) in
            
        }).disposed(by: self.disposeBag)
    }
}



//MARK: - 文档上的Observable
extension LearningRXDocments {
    private func observable() {
        let ob = Observable<Bool>.create { (observer) -> Disposable in
            print("一般的 observer 构造函数")
            observer.onNext(true)
            return Disposables.create()
        }
        
        ob.subscribe { (event) in
            print("一般的 observer subscribe 1")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("一般的 observer subscribe 2")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("一般的 observer subscribe 3")
            }.disposed(by: disposeBag)
    }
    
    private func single() {
        let ob = Single<Bool>.create { (observer) -> Disposable in
            print("Single 构造函数")
            observer(.success(true))
            return Disposables.create()
        }
        _ = Observable.just(false).asSingle()
        
        ob.subscribe { (event) in
            print("Single subscribe 1")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("Single subscribe 2")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("Single subscribe 3")
            }.disposed(by: disposeBag)
    }
    
    private func completable() {
        let ob = Completable.create { (observer) -> Disposable in
            print("Completable 构造函数")
            observer(.completed)
            return Disposables.create()
        }
        
        ob.subscribe { (event) in
            print("completable subscribe 1")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("completable subscribe 2")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("completable subscribe 3")
            }.disposed(by: disposeBag)
    }
    
    private func maybe() {
        let ob = Maybe<Bool>.create { (observer) -> Disposable in
            print("Maybe 构造函数")
            observer(.completed)
            return Disposables.create()
        }
        
        ob.subscribe { (event) in
            print("Maybe subscribe 1")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("Maybe subscribe 2")
            }.disposed(by: disposeBag)
        
        ob.subscribe { (event) in
            print("Maybe subscribe 3")
            }.disposed(by: disposeBag)
    }
    
    private func driver() {
        let ob = Observable<Bool>.create { (observer) -> Disposable in
            print("Driver 构造函数")
            observer.onNext(true)
            return Disposables.create()
            }.asDriver(onErrorJustReturn: false)
        
        ob.drive(onNext: { (_) in
            print("Driver subscribe 1")
        }).disposed(by: disposeBag)
        
        ob.drive(onNext: { (_) in
            print("Driver subscribe 2")
        }).disposed(by: disposeBag)
        
        ob.drive(onNext: { (_) in
            print("Driver subscribe 3")
        }).disposed(by: disposeBag)
    }
    
    private func signal() {
        let ob = Observable<Bool>.create { (observer) -> Disposable in
            print("Signal 构造函数")
            observer.onNext(true)
            return Disposables.create()
            }.asSignal(onErrorJustReturn: false)
        
        ob.emit(onNext: { (_) in
            print("Signal subscribe 1")
        }).disposed(by: disposeBag)
        
        ob.emit(onNext: { (_) in
            print("Signal subscribe 2")
        }).disposed(by: disposeBag)
        
        ob.emit(onNext: { (_) in
            print("Signal subscribe 3")
        }).disposed(by: disposeBag)
    }
}

//MARK: - 文档上的 Observable & Observer 既是可监听序列也是观察者
extension LearningRXDocments {
    private func asyncSubject() {
        let disposeBag = DisposeBag()
        let subject = AsyncSubject<String>.init()
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        //        subject.onNext("🐶")
        //        subject.onNext("🐱")
        //        subject.onError(CustomError.test)
        //        subject.onNext("🐹")
        subject.onCompleted()
        
        subject
            .subscribe { print("Subscription: 3 Event:", $0) }
            .disposed(by: disposeBag)
    }
    
    private func publishSubject() { //只能接收订阅以后 发出的内容
        //。如果你希望观察者接收到所有的元素，你可以通过使用 Observable 的 create 方法来创建 Observable，或者使用 ReplaySubject。
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>.init()
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🅰️")
        subject.onNext("🅱️")
    }
    
    func replaySubject() {
        let disposeBag = DisposeBag()
        let subject = ReplaySubject<String>.create(bufferSize: 30)
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🅰️")
        subject.onNext("🅱️")
    }
    
    func behaviorSubject() {
        let disposeBag = DisposeBag()
        let subject = BehaviorSubject(value: "🔴")
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🅰️")
        subject.onNext("🅱️")
        
        subject
            .subscribe { print("Subscription: 3 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🍐")
        subject.onNext("🍊")
    }
}

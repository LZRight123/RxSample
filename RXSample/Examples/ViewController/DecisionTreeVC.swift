//
//  DecisionTreeVC.swift
//  RXSample
//
//  Created by liangze on 2019/9/7.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
import RxSwift
class DecisionTreeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var dataSource: [SectionType]!
    
    enum SectionType {
        case createAObservable(arr: [Model])
        case createACombinationObervable(arr: [Model])
        case mapWithObservable(arr: [Model])
        
        var value: (sectionTitle: String, sectionCount: Int) {
            switch self {
            case .createAObservable(let arr):
                return ("我想要创建一个Observable", arr.count)
            case .createACombinationObervable(let arr):
                return ("我想要创建一个 Observable 通过组合其他的 Observables", arr.count)
            case .mapWithObservable(let arr):
                return ("我想要转换 Observable 的元素后，再将它们发出来", arr.count)
            }
        }
        
        func modelOf(_ indexPath: IndexPath) -> Model {
            switch self {
            case .createAObservable(let arr):
                return arr[indexPath.row]
            case .createACombinationObervable(let arr):
                return arr[indexPath.row]
            case .mapWithObservable(let arr):
                return arr[indexPath.row]
            }
        }
    }
    
    deinit {
        print("DecisionTreeVC deinit")
    }
    
    let sectionHeaderHeight: CGFloat = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Decision Tree Of Operator"
        dataSource = [
            .createAObservable(arr: [
                    Model(title: "just 产生特定的一个元素, 创建 Observable 发出唯一的一个元素", event: { [unowned self] in  self.just() }),
                    Model(title: "from 从一个序列拉取元素 将其他类型或者数据结构转换为 Observable", event: { [unowned self] in  self.from() }),
                    Model(title: "repeatElement 创建 Observable 重复的发出某个元素", event: { [weak self] in self?.repeatElement()}),
                    Model(title: "create 创建一个 Observable，你需要提供一个构建函数，在构建函数里面描述事件（next，error，completed）的产生过程。通常情况下一个有限的序列，只会调用一次观察者的 onCompleted 或者 onError 方法。并且在调用它们后，不会再去调用观察者的其他方法。", event: { [unowned self] in self.create()}),
                    Model(title: "deferred 操作符将等待观察者订阅它，才创建一个 Observable，它会通过一个构建函数为每一位订阅者创建新的 Observable。看上去每位订阅者都是对同一个 Observable 产生订阅，实际上它们都获得了独立的序列。", event: { print("no code")}),
                    Model(title: "interval 操作符将创建一个 Observable，它每隔一段设定的时间，发出一个索引数的元素。它将发出无数个元素。", event: { [unowned self] in self.interval()}),
                    Model(title: "empty 操作符将创建一个 Observable，这个 Observable 只有一个完成事件。", event: {}),
                    Model(title: "never 操作符将创建一个 Observable，这个 Observable 不会产生任何事件。", event: { })
                ]),
            .createACombinationObervable(arr: [
                Model(title: "merge 任意一个 Observable 产生了元素，就发出这个元素\n通过使用 merge 操作符你可以将多个 Observables 合并成一个，当某一个 Observable 发出一个元素时，他就将这个元素发出。                    如果，某一个 Observable 发出一个 onError 事件，那么被合并的 Observable 也会将它发出，并且立即终止序列。", event: { [unowned self] in self.merge() }),
                Model(title: "concat 操作符将多个 Observables 按顺序串联起来，当前一个 Observable 元素发送完毕后，后一个 Observable 才可以开始发出元素。concat 将等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅。如果后一个是“热” Observable ，在它前一个 Observable 产生完成事件前，所产生的元素将不会被发送出来。startWith 和它十分相似。但是startWith不是在后面添加元素，而是在前面插入元素。merge 和它也是十分相似。merge并不是将多个 Observables 按顺序串联起来，而是将他们合并到一起，不需要 Observables 按先后顺序发出元素。", event: { [unowned self] in self.concat() }),
                    Model(title: "zip 当每一个 Observable 都发出一个新的元素。zip操作符将多个(最多不超过8个) Observables 的元素通过一个函数组合起来，然后将这个组合的结果发出来。它会严格的按照序列的索引数进行组合。例如，返回的 Observable 的第一个元素，是由每一个源 Observables 的第一个元素组合出来的。它的第二个元素 ，是由每一个源 Observables 的第二个元素组合出来的。它的第三个元素 ，是由每一个源 Observables 的第三个元素组合出来的，以此类推。它的元素数量等于源 Observables 中元素数量最少的那个。", event: { [unowned self] in self.zip() }),
                    Model(title: "combineLatest 操作符将多个 Observables 中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来。这些源 Observables 中任何一个发出一个元素，他都会发出一个元素（前提是，这些 Observables 曾经发出过元素）", event: { [unowned self] in self.combineLatest() }),
                ]),
            .mapWithObservable(arr: [
                    Model(title: "map", event: { [unowned self] in self.map() }),
                    Model(title: "flatMap", event: { [unowned self] in self.flatMap() }),
                    Model(title: "flatMapLatest", event: { [unowned self] in self.flatMapLatest() }),
                    Model(title: "concatMap", event: { [unowned self] in self.concatMap() }),
                    Model(title: "scan", event: { [unowned self] in self.scan()  }),
                ])
        ]
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = sectionHeaderHeight
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension DecisionTreeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].value.sectionCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: sectionHeaderHeight))
        label.backgroundColor = .red
        label.text = "   " + dataSource[section].value.sectionTitle
        return label
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = dataSource[indexPath.section].modelOf(indexPath).title
        cell.textLabel?.font = .systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath.section].modelOf(indexPath).event()
    }
}

//MARK: - Operator
extension DecisionTreeVC {
    private func just() {
        let ob1 = Observable.just(false)
        ob1.subscribe { (event) in
            print("ob1   \(event)")
        }.disposed(by: disposeBag)
        
        // 相当于
        let ob2 = Observable<Bool>.create { (observer) -> Disposable in
            observer.onNext(false)
            observer.onCompleted()
            return Disposables.create()
        }
        ob2.subscribe { (event) in
            print("ob2   \(event)")
            }.disposed(by:disposeBag)
        
        let ob3 = Maybe.just(false)
        ob3.subscribe { (event) in
            print("ob3   \(event)")
        }.disposed(by: disposeBag)
        
        let ob4 = Single.just(false)
        ob4.subscribe { (event) in
            print("ob4   \(event)")
            }.disposed(by: disposeBag)
    }
    
    private func from() {
        let ob = Observable.from([1, 2, 3, 4, 5])
        ob.subscribe { (event) in
            print("\(event)")
        }
        .disposed(by: disposeBag)
        
        //相当于
        _ = Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func repeatElement() {
        let ob = Observable.repeatElement("repeat ?", scheduler: SerialDispatchQueueScheduler(internalSerialQueueName: "back"))
        ob
            .takeUntil(self.rx.deallocating)
            .subscribe { (event) in
            print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private func create() {
        let _ = Observable<Int>.create { observer in
            print("构建")
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onNext(6)
            observer.onNext(7)
            observer.onNext(8)
            observer.onNext(9)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func interval() {
        let ob = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        ob.subscribe { (event) in
            print("\(event)")
            }
            .disposed(by: disposeBag)
    }

}

//MARK: - 我想要创建一个 Observable 通过组合其他的 Observables 组合
extension DecisionTreeVC {
    private func merge() {
        let disposeBag = DisposeBag()
        
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("🅰️")
        
        subject1.onNext("🅱️")
        
        subject2.onNext("①")
        
//        subject2.onCompleted()
        subject1.onError(CustomError.test)
        subject2.onNext("②")
        
        subject1.onNext("🆎")
        
        subject2.onNext("③")
    }
    
    private func concat() {
        let subject1 = BehaviorSubject(value: "🍎")
        let subject2 = BehaviorSubject(value: "🐶")
        
        let variable = BehaviorRelay(value: subject1)
        
        variable
            .concat()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        variable.accept(subject2)

        subject1.concat(subject2)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        subject1.onNext("🍐")
        subject1.onNext("🍊")
        
        subject2.onNext("I would be ignored")
        
        subject1.onCompleted()

        subject2.onNext("🐱")
        subject2.onNext("🐭")
    }
    
    private func zip() {
        let first = PublishSubject<Int>()
        let second = PublishSubject<String>()
        
        Observable.zip(first, second) { "\($0)" + $1 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        first.onNext(1)
        second.onNext("A")
        
        first.onNext(2)
        second.onNext("B")
        
        second.onNext("C")
        second.onNext("D")
        
        first.onNext(3)
        first.onNext(4)
        first.onNext(5)
    }
    
    private func combineLatest() {
        let first = PublishRelay<Int>()
        let second = PublishRelay<String>()
        //要两个都有新值 才行
//        let first = BehaviorRelay<Int>(value: 0)
//        let second = BehaviorRelay<String>(value: "zero")

        Observable.combineLatest(first, second)
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)
        
        first.accept(1)
        first.accept(2)
        
        second.accept("one")
    }
}

//MARK: - 我想要转换 Observable 的元素后，再将它们发出来
extension DecisionTreeVC {
    private func map() {
        
    }
    
    private func flatMap() {
        
    }
    
    private func flatMapLatest() {
        
    }
    
    private func concatMap() {
        
    }
    
    private func scan() {
        
    }
}

//MARK: - 我想要将产生的每一个元素，拖延一段时间后再发出
extension DecisionTreeVC {
    private func delay() { }
}
//MARK: - 我想要将产生的事件封装成元素发送出来
extension DecisionTreeVC {
    private func materialaize() { }
    private func dematerialize() { }
}
//MARK: - 我想要忽略掉所有的 next 事件，只接收 completed 和 error 事件
//MARK: - 我想创建一个新的 Observable 在原有的序列前面加入一些元素
//MARK: - 我想从 Observable 中收集元素，缓存这些元素之后在发出
//MARK: - 我想将 Observable 拆分成多个 Observables
//MARK: - 我想只接收 Observable 中特定的元素
//MARK: - 我想重新从 Observable 中发出某些元素
extension DecisionTreeVC {
    private func filter() { }
    private func take() { }
    private func takeLast() { }
    private func elementAt() { }
    private func skip() { }
    private func skipWhile() { }
    private func skipUntil() { }
    private func takeWhile() { }
    private func takeUntil() { }
    private func sample() { }
    private func debounce() { }
    private func distinctUntilChanged() { }
    private func delaySubscription() { }
}
//MARK: - 我想要从一些 Observables 中，只取第一个产生元素的 Observable
//MARK: - 我想评估 Observable 的全部元素
//MARK: - 我想把 Observable 转换为其他的数据结构：as...
//MARK: - 我想要 Observable 发生某个事件时, 采取某个行动：do
//MARK: - 我想要 Observable 发出一个 error 事件：error
//MARK: - 我想要 Observable 发生错误时，优雅的恢复
//MARK: - 我创建一个 Disposable 资源，使它与 Observable 具有相同的寿命：using
//MARK: - 我创建一个 Observable，直到我通知它可以产生元素后，才能产生元素：publish

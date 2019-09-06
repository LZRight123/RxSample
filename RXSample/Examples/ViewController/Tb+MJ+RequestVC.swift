//
//  Tb+MJ+RequestVC.swift
//  RXSample
//
//  Created by liangze on 2019/9/6.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
//@_exported import RxSwift
import RxSwift
@_exported import Moya
@_exported import MJRefresh
import Kingfisher
import SDWebImage

public extension Reactive where Base: MJRefreshComponent {
    //正在刷新事件
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    //停止刷新
    var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
}

public enum EndMJFooter {
    case none, end, endWithNoMoreData
}
public extension Reactive where Base: MJRefreshFooter{
    //停止刷新 没有更多
    var endFooter: Binder<EndMJFooter> {
        return Binder(base) { refresh, endStatus in
            switch endStatus{
            case .end:
                refresh.endRefreshing()
            case .endWithNoMoreData:
                refresh.endRefreshingWithNoMoreData()
            case .none:
                break
            }
        }
    }
}



class Tb_MJ_RequestVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton()
            .then {
                $0.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                $0.setTitle("刷新", for: .normal)
                $0.setTitleColor(.blue, for: .normal)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
        configMJHeaderRefresh()
    
    }
    
    
    let dataSource = BehaviorRelay(value: [SongModel]())
    func configMJHeaderRefresh() {
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        
        
        let headerRefreshing = tableView.mj_header.rx.refreshing.asDriver()
            .startWith(())
            .flatMapLatest { _ in
                fmProvider.rx.request(.playlist(index: 0))
                    .mapArray(SongModel.self, atKeyPath: "song")
                    .catchErrorJustReturn([])
                    .asDriver(onErrorJustReturn: [])
            }
        headerRefreshing
            .drive(onNext: { [weak self] (arr) in
                self?.dataSource.accept(arr)
            })
            .disposed(by: disposeBag)
        
        headerRefreshing.map{ _ in true }
            .drive(tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        let footerRefreshing = tableView.mj_footer.rx.refreshing.asDriver()
            .flatMapLatest { _ in
                fmProvider.rx.request(.playlist(index: 0))
                    .mapArray(SongModel.self, atKeyPath: "song")
                    .catchErrorJustReturn([])
                    .asDriver(onErrorJustReturn: [])
            }
        footerRefreshing
            .drive(onNext: { [weak self] (arr) in
                guard let self = self else { return }
                self.dataSource.accept(self.dataSource.value + arr)
            })
            .disposed(by: disposeBag)
       
        
        dataSource.asDriver()
            .map { $0.count == 5 ? EndMJFooter.endWithNoMoreData : EndMJFooter.end }
            .debug()
            .drive(tableView.mj_footer.rx.endFooter)
            .disposed(by: disposeBag)
        
        
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: "HomeCell", cellType: HomeCell.self)) { (row, model, cell) in
                cell.iconView.kf.setImage(with: URL(string: model.picture))
                cell.titleLabel.text = model.title
                cell.subtitleLabel.text =  model.singers.first?.genre.joined(separator: ",")
            }
            .disposed(by: disposeBag)        
    }
}

//extension Tb_MJ_RequestVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource.value.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
//        let model = dataSource.value[indexPath.row]
//        cell.imageView?.kf.setImage(with: URL(string: model.picture))
//        cell.textLabel?.text = model.title
//        cell.detailTextLabel?.text =  model.singers.first?.genre.joined(separator: ",")
//
//        return cell
//
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//}

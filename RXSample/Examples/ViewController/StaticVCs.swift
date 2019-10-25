//
//  StaticVCs.swift
//  RXSample
//
//  Created by liangze on 2019/10/23.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
import RxSwift


class StaticVCs: UIViewController {
    let disposeBag = DisposeBag()

    let yqm = "邀请码帮助说明"
    
    private lazy var tableView = UITableView(style: .plain, backgroundColor: .beijinghui)
           .then{
               $0.regiseter(UITableViewCell.self) //快捷注册cell方法 莫认 identifier = classname
           }

    struct Model {
        let title: String
        let viewname: String
    }
    
    lazy var dataSource = BehaviorRelay<[Model]>(value:[
        Model(title: yqm, viewname: "yqmbzsm")
    ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: UITableViewCell.identifier, cellType: UITableViewCell.self))
            { (row, model, cell) in
                cell.textLabel?.text = model.title
            }
            .disposed(by: disposeBag)
               
        tableView.rx.modelSelected(Model.self)
            .subscribe(onNext: { [unowned self] (model) in
                self.pushTo(model)
            })
            .disposed(by: disposeBag)

        
    }
    
    
    func pushTo(_ model: Model){
        let nextVC = WebVC()
        nextVC.resource = model.viewname
        show(nextVC, sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  QucikUIVC.swift
//  RXSample
//
//  Created by liangze on 2019/9/30.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit
import RxSwift

class QucikUIVC: UIViewController {
    let disposeBag = DisposeBag()
    typealias Model = String
    
    private lazy var tableView = UITableView(style: .plain, backgroundColor: .beijinghui)
        .then{
            $0.regiseter(QucikFirstCell.self) //快捷注册cell方法 莫认 identifier = classname
            $0.regiseter(UITableViewCell.self)
        }.then{
            $0.backgroundView = UIView(color: .random)
            // cellfor row 取
            let cell = QucikFirstCell.dequeueReusable(for: $0)
        }
    
    
    let qucikLabel1 = UILabel(font: .font13, textColor: .hex222222)
    let qucikLabel2 = UILabel(font: .font13, textColor: .hex222222, text: nil)
    let qucikLabel3 = UILabel(font: .font13, textColor: .hex222222, text: nil, numberOfLines: 0).then{
        $0.backgroundColor = .random
    }
    
    
    
    private lazy var dataSource = BehaviorRelay<[Model]>(value: ["加载sb的vc，cell", "从xib加载View", "ToolBarForSBVC", String.randomString(100)])
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "快速UI 根目录"
        
        view.addSubviews(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        /*
        _ = UIView.fromNib()
        tableView.regiseter(QucikFirstCell.self)
        tableView.regiseter(nib: QucikFirstCell.self)
        _ = QucikFirstCell.dequeueReusable(for: tableView)
        let label = UILabel(font: .font7, textColor: .hex050505, numberOfLines: 0)
        let btn = UIButton(font: .font19, title: "确定", titleColor: .hex222222, image: UIImage(named: ""))
        _ = UIStackView(arrangedSubviews: [label, btn], spacing: 10, alignment: .leading, distribution: .fill, axis: .vertical)
        
        tableView.animate(
            Animation.fadeIn(),
            Animation.move(byX: 0, y: 10)
        )
        */
        
        
        
//        dataSource
//            .bind(to: tableView.rx.items) { (tableView, row, element) in
//                // 快捷取出cell的方法
//                let cell = QucikFirstCell.dequeueReusable(for: tableView)
//                cell.textLabel?.text = "\(element) @ row \(row)"
//                return cell
//            }
//            .disposed(by: disposeBag)
        
        // 因为整个section只有一种CELL 所以用下面这种方式， 多个cell用上面的方式
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: QucikFirstCell.identifier, cellType: QucikFirstCell.self))
            { (row, model, cell) in
                cell.bind(model)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Model.self)
            .subscribe(onNext: { [unowned self] (model) in
                self.pushTo(model)
            })
            .disposed(by: disposeBag)
    }
    
    private func pushTo(_ model: Model) {
        switch model {
        case "加载sb的vc，cell":
            let nextVC = LoadSBTableVC.fromSb(.Test)
            show(nextVC, sender: nil)
        case "从xib加载View":
            let nibView = XibView.fromNib()
            nibView.backgroundColor = .random
            view.addSubview(nibView)
            nibView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.left.equalToSuperview().offset(30)
            }
            
            nibView.animate(Animation.fadeOut(3))
        case "ToolBarForSBVC":
            let nextVC = ToolBarForSBVC.fromSb(.Test)
            show(nextVC, sender: nil)
        default:
            
            break
        }
    }
    
}


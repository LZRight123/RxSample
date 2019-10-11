//
//  TwoVC.swift
//  RXSample
//
//  Created by liangze on 2019/10/11.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

class TwoVC: UIViewController, SegementSlideContentScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    var scrollView: UIScrollView {
        return tableView
    }
    
    lazy var tableView = UITableView(style: .plain)
        .then {
            $0.dataSource = self
            $0.delegate = self
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.regiseter(UITableViewCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.dequeueReusable(for: tableView)
        cell.textLabel?.text = "\(indexPath.section) -  \(indexPath.row)"
        return cell
    }
    
}

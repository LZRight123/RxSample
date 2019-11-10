//
//  LoadSBTableVC.swift
//  RXSample
//
//  Created by liangze on 2019/9/30.
//  Copyright © 2019 liangze. All rights reserved.
//

import UIKit

extension String {
    fileprivate var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

class LoadSBTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let label = UILabel(numberOfLines: 0)
        
        view.addSubviews(label)
        
        label.snp.makeConstraints{
            $0.left.equalToSuperview().offset(15);
            $0.right.equalToSuperview().offset(-15);
            $0.top.equalToSuperview().offset(50);
        }
        label.preferredMaxLayoutWidth = ScreenWidth - 30
        
        let fileurl = Bundle.main.url(forResource: "yqmbzsm", withExtension: "html")!
        
        guard let str = try? String(contentsOf: fileurl, encoding: .utf8) else { return }
        let data = str.data(using: String.Encoding.utf8)!
        
        let atrStr = try! NSAttributedString(data: data, options: [
            NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html
//            NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue
        ], documentAttributes: nil)
        label.attributedText = atrStr
        
        
        let html = """
        <html>
        <body>
        <h1>Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!</h1>
        </body>
        </html>
        """
        let data2 = Data(html.utf8)

        if let attributedString = try? NSAttributedString(data: data2, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//            label.attributedText = attributedString
        }
        
    }
        
        
        

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 
}

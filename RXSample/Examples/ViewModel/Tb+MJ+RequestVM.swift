//
//  Tb+MJ+RequestVM.swift
//  RXSample
//
//  Created by liangze on 2019/9/6.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class FirstVM {
    //Input
    
    //Output
    let dataSource = BehaviorRelay(value: [SongModel]())
    let endHeaderRefresh: Driver<Bool>
    let endFooterRefresh: Driver<EndMJFooter>
    var page = 1
    
//    dependency
    init(input:(
            headerRefresh: ControlEvent<Void>,
            otherRefresh:  ControlEvent<Void>,
            footerRefresh: ControlEvent<Void>),
        disposeBag: DisposeBag
        ) {
        
        
        let headerRequest = input.headerRefresh.asDriver()
            .startWith(())
            .flatMap{ _ in
                FristService.originGetPlayList(1)
            }
        
        endHeaderRefresh = headerRequest.asDriver()
            .map{ _ in true }
        
        endFooterRefresh = dataSource.asDriver()
            .map { $0.count == 5 ? EndMJFooter.endWithNoMoreData : EndMJFooter.end }
        
        headerRequest
            .drive(onNext: { [weak self] (arr) in
                self?.dataSource.accept(arr)
                self?.page = 1

            })
            .disposed(by: disposeBag)
        
        input.footerRefresh.asDriver()
            .map{ [weak self] in
                self?.page += 1
                return self?.page ?? 0
            }
            .debug("上提加载更多")
            .flatMap{ count in
                FristService.originGetPlayList(count)
            }
            .drive(onNext: { [weak self] (arr) in
                guard let self = self else { return }
                self.dataSource.accept(self.dataSource.value + arr)
            })
            .disposed(by: disposeBag)
        
        input.otherRefresh.asDriver()
            .flatMap{ _ in
                FristService.originGetPlayList(1)
            }
            .drive(onNext: { [weak self] (arr) in
                self?.dataSource.accept(arr)
                self?.page = 1
            })
            .disposed(by: disposeBag)
        
//        input.otherRefresh.asDriver()
//        .flatMap{ _ in
//            FristService.originGetPlayList(1)
//        }
//        .asObservable().subscribeNext { (arr) in
//            
//        }
    }
}


struct FristService {
    static func getPlayList(_ index: Int) -> Driver<[SongModel]> {
        return fmProvider.rx.request(.playlist(index: index))
            .mapArray(SongModel.self, atKeyPath: "song")
            .asDriver(onErrorJustReturn: [])
    }
    
    static func originGetPlayList(_ index: Int)  -> Driver<[SongModel]> {
        let str = "https://douban.fm/j/mine/playlist?type=n&channel=\(index)&from=mainsite"
        
        return Single.create {  single in
            print("请求开始: \(index)")
            let cancellableToken = URLSession.shared.dataTask(with: URL(string: str)!) { (data, response, error) in
                let response = Moya.Response(statusCode: 200, data: data ?? Data())
                print("回调 \(index)")
                if let arr = try? response.mapArray(SongModel.self, atKeyPath: "song") {
//                    print("成功")
                    single(.success(arr))
                } else {
//                    print("失败")
                    single(.error(MoyaError.imageMapping(response)))
                }
            }
            cancellableToken.resume()
            
            return Disposables.create {
                print("上次的请求cancel了 \(index)")
                cancellableToken.cancel()
            }
        }.asDriver(onErrorJustReturn: [])
    }
    
    
    
    
    
    
    
}

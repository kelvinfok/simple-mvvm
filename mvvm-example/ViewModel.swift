//
//  ViewModel.swift
//  mvvm-example
//
//  Created by Kelvin Fok on 2/9/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func didStartFetchingMessage()
    func didFinishFetchingMessage(_ message: String)
}

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func fetchMessage() {
        delegate?.didStartFetchingMessage()
        DispatchQueueHelper.delay(bySeconds: 3.0, dispatchLevel: .background) {
            let message = "Hello there"
            DispatchQueueHelper.delay(bySeconds: 0.0, completion: {
                self.delegate?.didFinishFetchingMessage(message)
            })
        }
    }
}

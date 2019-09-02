//
//  ViewController.swift
//  mvvm-example
//
//  Created by Kelvin Fok on 2/9/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {
    
    var viewModel: ViewModel! {
        didSet {
            updateViews()
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Tap 'Fetch' to retrieve message"
        return label
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.hidesWhenStopped = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
    
    private func setupViewModel() {
        let user = User(name: "Kelmo", age: 34, backgroundColor: .white)
        viewModel = ViewModel(user: user)
        viewModel.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(activityIndicatorView)
        label.center(in: view)
        activityIndicatorView.topToBottom(of: label, offset: 16)
        activityIndicatorView.centerX(to: view)
    }
    
    private func updateViews() {
        view.backgroundColor = viewModel.user.backgroundColor
        navigationItem.title = viewModel.user.name
    }

    @IBAction func fetchButtonTapped(_ sender: Any) {
        viewModel.fetchMessage()
        
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        label.text = "Tap 'Fetch' to retrieve message"
    }
}

extension ViewController: ViewModelDelegate {
    
    func didStartFetchingMessage() {
        activityIndicatorView.startAnimating()
    }
    
    func didFinishFetchingMessage(_ message: String) {
        label.text = message
        activityIndicatorView.stopAnimating()
    }
    
}

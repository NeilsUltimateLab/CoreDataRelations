//
//  AddReferralViewController.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit

class AddReferralViewController: UIViewController {
    
    enum PropertyField: Int {
        case name
        
        var indexPath: IndexPath {
            return IndexPath(item: self.rawValue, section: 0)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [PropertyField: TextValue] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupDataSource()
        setupTableView()
        observeKeyboard()
    }
    
    func setupNavigationItems() {
        self.title = "Add Referral"
        self.navigationItem.largeTitleDisplayMode = .never
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveAction() {
        guard let name = dataSource[.name]?.value else { return }
        
        let result = Referral.create(name: name)
        switch result {
        case .value(let success):
            if success {
                self.navigationController?.popViewController(animated: true)
            }
        case .error(let error):
            print(error)
        }
    }
    
    func setupDataSource() {
        dataSource[.name] = TextValue(name: "Referral name")
    }
    
    func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 65
        self.tableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceVertical = true
        self.tableView.keyboardDismissMode = .interactive
    }
    
    func observeKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in
            print(notification)
            guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height else {
                return
            }
            self?.tableView.contentInset.bottom = keyboardHeight
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            print(notification)
            self?.tableView.contentInset.bottom = 0
        }
    }
    
}

extension AddReferralViewController: UITableViewDelegate {
    
}

extension AddReferralViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = PropertyField(rawValue: indexPath.row), let value = dataSource[type] else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as? TextFieldCell else {
            return UITableViewCell()
        }
        cell.configure(with: value)
        return cell
    }
}


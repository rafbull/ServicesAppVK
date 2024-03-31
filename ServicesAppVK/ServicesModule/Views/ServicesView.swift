//
//  ServicesView.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit

final class ServicesView: UIView {
    lazy var tableView: UITableView = createTableView()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    private(set) lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Private Methods
    private func createTableView() -> UITableView {
        tableView = UITableView()
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.identifier)
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    private func setupUI() {
        addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

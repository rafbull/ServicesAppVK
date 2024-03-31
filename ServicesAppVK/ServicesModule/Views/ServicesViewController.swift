//
//  ServicesViewController.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit
import Combine

final class ServicesViewController: UIViewController {
    
    // MARK: Initialization
    init(viewModel: ServicesViewModelProtocol = ServicesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getServices()
        checkInternetConnection()
        applySnapshot()
    }
    
    // MARK: - Private Properties
    private let viewModel: ServicesViewModelProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var contentView: ServicesView = {
        let contentView = ServicesView()
        contentView.tableView.delegate = self
        contentView.refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return contentView
    }()
    
    private lazy var dataSource: ServicesTableViewDiffableDataSource = createDataSource()
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ServicesTableViewSection, Service>
    
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Сервисы"
    }
    
    // Creating Data Source
    private func createDataSource() -> ServicesTableViewDiffableDataSource {
        dataSource = ServicesTableViewDiffableDataSource(tableView: contentView.tableView, cellProvider: { [weak self] tableView, indexPath, service in
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.identifier, for: indexPath) as? ServiceTableViewCell
            let serviceIconImage = self?.viewModel.getImage(from: service.iconURL)
            cell?.viewModel = ServiceCellViewModel(service: service, serviceIconImage: serviceIconImage)
            return cell
        })
        return dataSource
    }
    
    private func applySnapshot() {
        viewModel.services
            .sink { [weak self] services in
                var snapshot = Snapshot()
                snapshot.appendSections([.services])
                snapshot.appendItems(services, toSection: .services)
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &subscriptions)
    }

    private func getServices() {
        viewModel.getServices(from: .services)
    }
    
    private func checkInternetConnection() {
        viewModel.isNoInternet
            .sink { [weak self] (isNoInternet) in
                if isNoInternet {
                    let alertController = UIAlertController(
                        title: AppConstant.noInternetAlertTitle,
                        message: AppConstant.noInternetAlertMessage,
                        preferredStyle: .alert
                    )
                    let alertAction = UIAlertAction(title: AppConstant.noInternetActionTitle, style: .default)
                    alertController.addAction(alertAction)
                    self?.present(alertController, animated: true)
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Extension UITableViewDelegate
extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let service = viewModel.services.value[indexPath.row]
        guard let appURL = URL(string: service.link) else { return }
        
        UIApplication.shared.open(appURL)
    }
}

// MARK: - Extension @objc didPullToRefresh
private extension ServicesViewController {
    @objc
    func didPullToRefresh(_ sender: UIRefreshControl) {
        getServices()
        contentView.refreshControl.endRefreshing()
    }
}

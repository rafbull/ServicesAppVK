//
//  ServiceTableViewCell.swift
//  ServicesAppVK
//
//  Created by Rafis on 31.03.2024.
//

import UIKit
import Combine

final class ServiceTableViewCell: UITableViewCell {
    
    static let identifier = "ServiceTableViewCell"
    
    var viewModel: ServiceCellViewModelProtocol? {
        didSet {
            sinkToViewModel()
        }
    }

    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Constants
    private enum UIConstants {
        static let serviceIconImageViewSize: CGFloat = 60
        static let serviceHStackViewSpacing: CGFloat = 16
    }
    
    // MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()
    
    private let serviceIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let serviceName: UILabel = {
        let label = UILabel()
        label.text = "Service Name"
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let serviceDescription: UILabel = {
        let label = UILabel()
        label.text = "Service Description"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var serviceLabelsVStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [serviceName, serviceDescription])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .fill
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private lazy var serviceHStackView: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [serviceIconImageView, serviceLabelsVStackView])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .fill
        hStack.spacing = UIConstants.serviceHStackViewSpacing
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    // MARK: - Private Methods
    private func sinkToViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.serviceName
            .combineLatest(viewModel.serviceIconImage, viewModel.serviceDescription)
            .sink { [weak self] serviceName, serviceIconImage, serviceDescription in
                self?.serviceIconImageView.image = serviceIconImage
                self?.serviceName.text = serviceName
                self?.serviceDescription.text = serviceDescription
            }
            .store(in: &subscriptions)
    }
    
    private func setupUI() {
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(serviceHStackView)
    }
    
    private func setConstraints() {
        let contentViewMargins = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            serviceHStackView.topAnchor.constraint(equalTo: contentViewMargins.topAnchor),
            serviceHStackView.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor),
            serviceHStackView.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor),
            serviceHStackView.bottomAnchor.constraint(equalTo: contentViewMargins.bottomAnchor),
            
            serviceIconImageView.widthAnchor.constraint(equalToConstant: UIConstants.serviceIconImageViewSize),
            serviceIconImageView.heightAnchor.constraint(equalTo: serviceIconImageView.widthAnchor),
        ])
    }
}

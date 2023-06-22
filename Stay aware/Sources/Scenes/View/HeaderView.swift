//
//  HeaderView.swift
//  Stay aware
//
//  Created by Олег Стригунов on 25.04.2023.
//

import UIKit
import SnapKit

class HeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "HeaderView"
    
    //MARK: - Outlets
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "HEADER"
        return label
    }()
    

    //MARK: - Init
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setups
    private func setupHierarchy() {
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
}

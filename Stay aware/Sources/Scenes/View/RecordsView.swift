//
//  RecordsView.swift
//  Stay aware
//
//  Created by Олег Стригунов on 17.05.2023.
//

import UIKit

class RecordsView: UIView {

    //MARK: - Outlets
    lazy var viewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1.0)
        view.layer.cornerRadius = 26
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        return view
    }()
    
    lazy var labelCurrentDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonNextYear: UIButton = {
        let button = UIButton()
        button.setTitle(" ", for: .normal)
                button.backgroundColor = UIColor.clear
                button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
                button.setImage(UIImage(systemName: "chevron.right.square.fill"), for: .normal)
                button.tintColor = UIColor.white
                button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonFastYear: UIButton = {
        let button = UIButton()
        button.setTitle(" ", for: .normal)
                button.backgroundColor = UIColor.clear
                button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
                button.setImage(UIImage(systemName: "chevron.backward.square.fill"), for: .normal)
                button.tintColor = UIColor.white
                button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 240/255, alpha: 1.0)
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none // убрать полоски между записями

        return tableView
    }()
    
    lazy var viewBarCollection: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 26
        view.clipsToBounds = true
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: FlowLayoutCell.indentifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
        
        tableView.sectionHeaderTopPadding = 0
    }
    
    //MARK: - Setup
    
    private func setupHierarchy() {
        backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 240/255, alpha: 1.0)
        addSubview(viewHeader)
            viewHeader.addSubview(viewBarCollection)
                viewBarCollection.addSubview(collectionView)
            viewHeader.addSubview(labelCurrentDate)
            viewHeader.addSubview(buttonNextYear)
            viewHeader.addSubview(buttonFastYear)
        addSubview(tableView)
    }
    
    private func setupLayout() {
        viewHeader.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(220)
        }
        
        labelCurrentDate.snp.makeConstraints { make in
            make.centerY.equalTo(viewHeader)
            make.centerX.equalTo(viewHeader)
            make.height.equalTo(46)
            make.width.equalTo(90)
        }
        
        buttonNextYear.snp.makeConstraints { make in
            make.centerY.equalTo(viewHeader)
            make.left.equalTo(labelCurrentDate.snp_rightMargin).offset(20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        buttonFastYear.snp.makeConstraints { make in
            make.centerY.equalTo(viewHeader)
            make.right.equalTo(labelCurrentDate.snp_leftMargin).offset(-20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        viewBarCollection.snp.makeConstraints { make in
            make.left.right.equalTo(viewHeader).inset(20)
            make.height.equalTo(120)
            make.bottom.equalTo(0).offset(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewHeader.snp_bottomMargin).inset(-80)
            make.left.bottom.right.equalTo(self)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalTo(viewBarCollection).inset(20)
            make.bottom.top.equalTo(viewBarCollection)
        }
    }

}

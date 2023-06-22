//
//  RecordTableViewCell.swift
//  Stay aware
//
//  Created by Олег Стригунов on 11.05.2023.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    static let identifier = "recordTableViewCell"

    var model: DayModel? {
           didSet {
               title.text = model?.note
               time.text = model?.time
               status.text = model?.status
               
               switch model?.status {
                   case "normal":
                       status.text = "😊"
                   case "happy":
                       status.text = "☺️"
                   case "sad":
                       status.text = "😔"
                   case .none:
                       status.text = "model?.status"
                   case .some(_):
                       status.text = "model?.status"
               }
           }
       }
       
       
       //MARK: - Outlets
    
    private let wrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

       private let title: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
           label.textColor = .black
           label.numberOfLines = 3
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let time: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    
    private let stackCell: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
       
       
       
       
       //MARK: - Init
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super .init(style: style, reuseIdentifier: reuseIdentifier)
           
           setupHierarchy()
           setupLayout()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       //MARK: - Setups
       
       private func setupHierarchy() {
           backgroundColor = .none
           addSubview(wrapper)
           wrapper.addSubview(stackCell)
           wrapper.addSubview(status)
           stackCell.addArrangedSubview(time)
           stackCell.addArrangedSubview(title)
       }
       
       private func setupLayout() {
           
           wrapper.snp.makeConstraints { make in
               make.left.right.equalTo(self).inset(20)
               make.top.bottom.equalTo(self).inset(10)
           }
           
           stackCell.snp.makeConstraints { make in
               make.left.top.right.bottom.right.equalTo(wrapper).inset(10)
           }
           
           
           
           time.snp.makeConstraints { make in
               make.width.equalTo(60)
           }
           
           status.snp.makeConstraints { make in
               make.top.equalTo(wrapper.snp_topMargin).inset(-16)
               make.left.equalTo(wrapper.snp_leftMargin).inset(-16)
               
           }
       }

}

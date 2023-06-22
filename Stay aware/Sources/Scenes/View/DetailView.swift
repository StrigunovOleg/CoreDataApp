//
//  DetailView.swift
//  Stay aware
//
//  Created by Олег Стригунов on 17.05.2023.
//

import UIKit

class DetailView: UIView {
    
    //MARK: - Outlets
    // Outlets textField
    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    lazy var detailTextView: UITextView = {
        let textField = UIKit.UITextView()
        textField.textColor = .black
        textField.font = UIFont(name: "San Francisco", size: 20)
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    private lazy var stackSave: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    lazy var buttonSaveTextField: UIButton = {
        let button = UIButton(type: .custom)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        button.tintColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonDelete: UIButton = {
        let button = UIButton(type: .custom)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
        button.setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        button.setImage(UIImage(systemName: "xmark.bin"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var stackStatusButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 6
        return stack
    }()
    
    lazy var statusHappyButton: UIButton = {
        let button = UIButton()
        button.setTitle("☺️", for: .normal)
        button.accessibilityIdentifier = Status.happy.rawValue
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var statusNormalButton: UIButton = {
        let button = UIButton()
        button.setTitle("😊", for: .normal)
        button.accessibilityIdentifier = Status.normal.rawValue
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6).cgColor
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var statusSadButton: UIButton = {
        let button = UIButton()
        button.setTitle("😔", for: .normal)
        button.accessibilityIdentifier = Status.sad.rawValue
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonDoneTextField: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 34))
        button.setTitle("Готово", for: .normal)
        
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.layer.cornerRadius = 16
        return button
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
        setupToolBar()
    }
    
    
    //MARK: - Setup
    
    private func setupToolBar() {
        // Создаем экземпляр UIToolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))

        // Создаем кнопку Done для закрытия клавиатуры
        let saveButton = UIBarButtonItem(customView: buttonDoneTextField)
        toolbar.backgroundColor = .white
        
        
        // Добавляем кнопку Done и гибкий промежуток на toolbar
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, saveButton]

        // Добавляем toolbar в текстовое поле
        detailTextView.inputAccessoryView = toolbar
    }
    
    private func setupHierarchy() {
        backgroundColor = .white
        addSubview(textFieldView)
            textFieldView.addSubview(buttonSaveTextField)
            textFieldView.addSubview(stackStatusButtons)
                    stackStatusButtons.addArrangedSubview(statusHappyButton)
                    stackStatusButtons.addArrangedSubview(statusNormalButton)
                    stackStatusButtons.addArrangedSubview(statusSadButton)
            textFieldView.addSubview(detailTextView)
            textFieldView.addSubview(buttonDelete)
    }
    
    private func setupLayout() {
        textFieldView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.left.right.equalTo(self).inset(20)
            make.bottom.equalTo(self)
        }
        
                buttonSaveTextField.snp.makeConstraints { make in
                    make.top.equalTo(textFieldView).inset(5)
                    make.right.equalTo(textFieldView.snp_rightMargin).inset(0)
                    make.height.equalTo(30)
                    make.width.equalTo(30)
                }
        
                stackStatusButtons.snp.makeConstraints { make in
                    make.top.equalTo(buttonSaveTextField.snp_bottomMargin).inset(-40)
                    make.left.right.equalTo(textFieldView).inset(10)
                    
                }
            
                detailTextView.snp.makeConstraints { make in
                    make.top.equalTo(stackStatusButtons.snp_bottomMargin).inset(-20)
                    make.left.right.equalTo(textFieldView)
                    make.bottom.equalTo(buttonDelete.snp_topMargin).inset(-20)
                    
                }
        
        buttonDelete.snp.makeConstraints { make in
            make.bottom.equalTo(textFieldView.snp_bottomMargin)
            make.right.equalTo(textFieldView.snp_rightMargin)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
    }
}

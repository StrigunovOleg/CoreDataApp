////
////  MainView.swift
////  Stay aware
////
////  Created by Олег Стригунов on 13.05.2023.
////

import UIKit
import SnapKit

class MainView: UIView {

    let screenSize = UIScreen.main.bounds.size

    //MARK: - Outlets
    private lazy var viewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1.0)
        view.layer.cornerRadius = 26
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    lazy var labelWelcome: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.text = K.MainView.welcomeLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewOptionsButton: UIButton = {
        let button = UIButton()
        button.setTitle(" ", for: .normal)
                button.backgroundColor = UIColor.clear
                button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
                button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
                button.tintColor = UIColor.white
                button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var viewBarItems: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 26
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var stackButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 6
        return stack
    }()
    
    
    // Outlets AllRecords
    private lazy var stackAllRecords: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var labelAllRecords: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonAllRecords: UIButton = {
        let button = UIButton()
        button.setTitle("ВСЕ\nЗАПИСИ", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
        button.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // Outlets Happy
    private lazy var stackHappy: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var labelHappy: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonHappy: UIButton = {
        let button = UIButton()
        button.setTitle("☺️", for: .normal)
        button.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // Outlets Normal
    private lazy var stackNormal: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var labelNormal: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonNormal: UIButton = {
        let button = UIButton()
        button.setTitle("😊", for: .normal)
        button.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // Outlets Sad
    private lazy var stackSad: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var labelSad: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonSad: UIButton = {
        let button = UIButton()
        button.setTitle("😔", for: .normal)
        button.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // Outlets textField
    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 26
        view.clipsToBounds = true
        return view
    }()
    
    
    lazy var mainRecordTextView: UITextView = {
        let textField = UIKit.UITextView()
        textField.delegate = self
        textField.textColor = .systemGray3
        textField.text = K.MainView.textForUITextField
        textField.font = UIFont.systemFont(ofSize: 24)
        return textField
    }()
    
    
    
    lazy var buttonSaveTextField: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 34))
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    
    lazy var statusHappyButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        button.setTitle("☺️", for: .normal)
        button.accessibilityIdentifier = Status.happy.rawValue
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var statusNormalButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        button.setTitle("😊", for: .normal)
        button.accessibilityIdentifier = Status.normal.rawValue
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6).cgColor
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var statusSadButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        //button.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        button.setTitle("😔", for: .normal)
        button.accessibilityIdentifier = Status.sad.rawValue
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
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
        setupHierarchy()
        setupLayout()
        setToolBar()
    }
    
    
    //MARK: - Setup
    
    func setToolBar() {
        //MARK: - TOOLBAR
        // Создаем экземпляр UIToolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1)

        // Создаем кнопку Done для закрытия клавиатуры
        let happyButton = UIBarButtonItem(customView: statusHappyButton)
        let normalButton = UIBarButtonItem(customView: statusNormalButton)
        let sadButton = UIBarButtonItem(customView: statusSadButton)
        let saveButton = UIBarButtonItem(customView: buttonSaveTextField)
        
        // Добавляем кнопки и гибкий промежуток на toolbar
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, happyButton, flexibleSpace, normalButton, flexibleSpace, sadButton, flexibleSpace, saveButton, flexibleSpace]
        // Добавляем toolbar в текстовое поле
        mainRecordTextView.inputAccessoryView = toolbar
    }
    
    private func setupHierarchy() {
        backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 240/255, alpha: 1.0)

        addSubview(viewHeader)
            viewHeader.addSubview(labelWelcome)
            viewHeader.addSubview(viewBarItems)
            viewHeader.addSubview(viewOptionsButton)
                viewBarItems.addSubview(stackButtons)
                    stackButtons.addArrangedSubview(stackAllRecords)
                        stackAllRecords.addArrangedSubview(buttonAllRecords)
                        stackAllRecords.addArrangedSubview(labelAllRecords)
                    stackButtons.addArrangedSubview(stackHappy)
                        stackHappy.addArrangedSubview(buttonHappy)
                        stackHappy.addArrangedSubview(labelHappy)
                    stackButtons.addArrangedSubview(stackNormal)
                        stackNormal.addArrangedSubview(buttonNormal)
                        stackNormal.addArrangedSubview(labelNormal)
                    stackButtons.addArrangedSubview(stackSad)
                        stackSad.addArrangedSubview(buttonSad)
                        stackSad.addArrangedSubview(labelSad)
        addSubview(textFieldView)
            textFieldView.addSubview(mainRecordTextView)
    }
    
    private func setupLayout() {
        
        self.snp.makeConstraints { make in
            make.height.equalTo(screenSize.height)
            make.width.equalTo(screenSize.width)
        }
        
        viewHeader.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(220)
        }
        
        labelWelcome.snp.makeConstraints { make in
            make.centerY.equalTo(viewHeader)
            make.centerX.equalTo(viewHeader)
        }
        
        viewOptionsButton.snp.makeConstraints { make in
            make.left.equalTo(viewHeader).inset(20)
            make.top.equalTo(viewHeader).inset(88)
        }
        
        viewBarItems.snp.makeConstraints { make in
            make.left.right.equalTo(viewHeader).inset(20)
            make.height.equalTo(120)
            make.bottom.equalTo(0).offset(60)
        }
        
        stackButtons.snp.makeConstraints { make in
            make.top.bottom.equalTo(viewBarItems)
            make.left.right.equalTo(viewBarItems).inset(10)
        }
        
        buttonAllRecords.snp.makeConstraints { make in
            make.height.width.equalTo(66)
        }
        
        buttonHappy.snp.makeConstraints { make in
            make.height.width.equalTo(66)
        }
        
        buttonNormal.snp.makeConstraints { make in
            make.height.width.equalTo(66)
        }
        
        buttonSad.snp.makeConstraints { make in
            make.height.width.equalTo(66)
        }
        
        textFieldView.snp.makeConstraints { make in
            make.top.equalTo(viewHeader.snp_bottomMargin).offset(100)
            make.left.right.equalTo(self).inset(20)
            make.bottom.equalTo(self).inset(40)
        }
        
        mainRecordTextView.snp.makeConstraints { make in
            make.top.equalTo(textFieldView).inset(20)
            make.left.right.equalTo(textFieldView).inset(20)
            make.bottom.equalTo(textFieldView.snp_bottomMargin).inset(20)
            
        }
    }
}


//
//  OptionsView.swift
//  Stay aware
//
//  Created by Олег Стригунов on 28.05.2023.
//

import UIKit

class OptionsView: UIView {
    

    //MARK: - Outlets
    lazy var labelOptions: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = K.OptionsView.optionLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    
    lazy var labelStatusSwitch: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .black
        label.text = "Присылать уведомления"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackStatusSwitch: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        //stack.spacing = 4
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    lazy var statusSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        statusSwitch.onTintColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1.0)
        return statusSwitch
    }()
    
    lazy var stackSettingTime: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        //stack.spacing = 4
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    lazy var stackEnabledNotification: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    var labelSetHour: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.isContinuous = true
        slider.tintColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1.0)
        return slider
    }()
    
    
    lazy var enableNotificationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Разрешить уведомления", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var setNotificationPauseButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = K.OptionsView.offNotif
        button.setTitle("Приостановить уведомления", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var setNotificationOneHourButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = K.OptionsView.oneHour
        button.setTitle("Присылать каждый час", for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .none
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var setNotificationTwoHourButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = K.OptionsView.twoHour
        button.setTitle("Присылать каждые 2 часа", for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .none
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var setNotificationTimePhaseButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = K.OptionsView.threePhase
        button.setTitle("Присылать 3 раза в день", for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .none
        button.layer.cornerRadius = 20
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
    }
    
    
    //MARK: - Setup
    private func setupHierarchy() {
        backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 1.0)
        addSubview(labelOptions)
        addSubview(enableNotificationButton)
        addSubview(stackEnabledNotification)
            stackEnabledNotification.addArrangedSubview(setNotificationPauseButton)
            stackEnabledNotification.addArrangedSubview(setNotificationOneHourButton)
            stackEnabledNotification.addArrangedSubview(setNotificationTwoHourButton)
            stackEnabledNotification.addArrangedSubview(setNotificationTimePhaseButton)
        
    }
    
    private func setupLayout() {
        
        labelOptions.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).inset(40)
        }
        
        enableNotificationButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(labelOptions.snp_bottomMargin).offset(50)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        
        stackEnabledNotification.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(labelOptions.snp_bottomMargin).offset(50)
        }

        setNotificationPauseButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
        
        setNotificationOneHourButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
        
        setNotificationTwoHourButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
        
        setNotificationTimePhaseButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
    }
}

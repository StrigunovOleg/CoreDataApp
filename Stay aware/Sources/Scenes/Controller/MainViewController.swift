//
//  MainViewController.swift
//  Stay aware
//
//  Created by Олег Стригунов on 29.04.2023.
//

import UIKit
import CoreData
import SnapKit


class MainViewController: UIViewController {
    
    
    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }
    
    var context: NSManagedObjectContext!
    var items: [Items] = []
    
    var textForUITextField = K.MainView.textForUITextField
    var selectedStatus: String = Status.normal.rawValue
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = MainView()
        setupActions()
        
        // Создание настраиваемой кнопки "Back"
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        backButton.tintColor = UIColor.white
        // Установка настраиваемой кнопки "Back" для представлений на стеке навигации
        navigationItem.backBarButtonItem = backButton

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getCurrentValueRecords()
    }
    
    func setupActions() {
        guard let mainView = mainView else { return }
        
        mainView.buttonAllRecords.addTarget(self, action: #selector(showAllRecords), for: .touchUpInside)
        mainView.buttonSaveTextField.addTarget(self, action: #selector(saveNewRecord), for: .touchUpInside)
        
        mainView.statusSadButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        mainView.statusHappyButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        mainView.statusNormalButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        
        mainView.buttonSad.addTarget(self, action: #selector(viewOptionSetupOpen), for: .touchUpInside)
        
        mainView.viewOptionsButton.addTarget(self, action: #selector(viewOptionSetupOpen), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc private func viewOptionSetupOpen() {
        let optionsVC = OptionsViewController()
        self.present(optionsVC, animated: true)
    }
    
        @objc private func saveNewRecord() {
            let mainTextView = mainView!.mainRecordTextView
            
            if mainTextView.text.isEmpty {
                mainTextView.resignFirstResponder()
                mainTextView.text = K.MainView.textForUITextField
                mainTextView.font = UIFont.systemFont(ofSize: 24)
                mainTextView.textColor = .systemGray3
            } else {
                //Запись данных CORE DATA
                guard let entity = NSEntityDescription.entity(forEntityName: "Items", in: context) else { return }
                let itemsObject = Items(entity: entity, insertInto: context)
                itemsObject.date = Date()
    
                itemsObject.note = mainTextView.text ?? ""
                itemsObject.state = selectedStatus
    
                do {
                    try context.save()
                    items.append(itemsObject)
                    mainTextView.resignFirstResponder()
                } catch let error as NSError {
                    printContent(error.localizedDescription)
                }
    
                getCurrentValueRecords()
                mainTextView.text = K.MainView.textForUITextField
                mainTextView.textColor = .systemGray3
                mainTextView.font = UIFont.systemFont(ofSize: 24)
                mainTextView.resignFirstResponder()
            }
        }
    
    @objc private func showAllRecords() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)

        let RecordsVC = RecordsViewController()
        if let navigator = navigationController {
            navigator.pushViewController(RecordsVC, animated: true)
            RecordsVC.context = context
            RecordsVC.currentYear = year
            RecordsVC.currentMonth = month
        }
    }
    
    
    
    private func getCurrentValueRecords() {
        var items: [Items] = []
        
        let fetchData: NSFetchRequest<Items> = Items.fetchRequest()
        fetchData.returnsObjectsAsFaults = false
        do {
            items = try context.fetch(fetchData)
            mainView!.labelAllRecords.text = "\(items.count)"
            
            var happy = 0
            var sad = 0
            var normal = 0
        
            for state in items {
                if state.state! == "happy" {
                    happy += 1
                } else if state.state! == "sad" {
                    sad += 1
                } else if state.state! == "normal" {
                    normal += 1
                }
            }
            
            mainView!.labelSad.text = "\(sad)"
            mainView!.labelHappy.text = "\(happy)"
            mainView!.labelNormal.text = "\(normal)"
            
        }
        catch let error as NSError {
            printContent(error.localizedDescription)
        }
    }
    
    
    @objc private func setStatus(_ sender: UIButton) {
        guard let mainView = mainView else { return }
        
        selectedStatus = sender.accessibilityIdentifier ?? ""
        
        let buttonsStatus: [UIButton] = [mainView.statusHappyButton, mainView.statusNormalButton, mainView.statusSadButton]
        
        for btn in buttonsStatus {
            btn.layer.borderColor = UIColor.white.cgColor
        }
        
        sender.layer.borderColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6).cgColor
    }
}


extension MainView: UITextViewDelegate {
    // Обработка начала редактирования текстового поля
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Yeap he is starting")
        if mainRecordTextView.text == K.MainView.textForUITextField {
            mainRecordTextView.text = ""
            mainRecordTextView.textColor = .black
            mainRecordTextView.font = UIFont.systemFont(ofSize: 20)
            buttonSaveTextField.setTitle("Отмена", for: .normal)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if mainRecordTextView.text == "" {
            buttonSaveTextField.setTitle("Отмена", for: .normal)
        } else {
            buttonSaveTextField.setTitle("Сохранить", for: .normal)
        }
    }
}

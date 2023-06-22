//
//  DetailViewController.swift
//  Stay aware
//
//  Created by Олег Стригунов on 06.05.2023.
//

import UIKit
import SnapKit
import CoreData

class DetailViewController: UIViewController {
    
    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    weak var delegate: UpdateTableView?
    
    var context: NSManagedObjectContext!
    var objectID: NSManagedObjectID?
    
    var statusValue: String!
    
    var selectedStatus: String = "happy" {
        didSet {
            setupStatus(status: selectedStatus)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = DetailView()
        
        setupData()
        
        detailView!.detailTextView.delegate = self
        
        setupActions()
    }
    
    
    
    //MARK: - Actions
    func setupData() {
        
        guard let objectID = objectID else {
            print("DON WORK")
            return
        }
        
        do {
            let object = try context.existingObject(with: objectID)
            detailView!.detailTextView.text = object.value(forKey: "note") as? String
            selectedStatus = object.value(forKey: "state") as? String ?? Status.normal.rawValue
            setupStatus(status: selectedStatus)
         } catch let error as NSError {
             print(error)
         }
       
    }
    
    private func setupStatus(status: String) {
        guard let detailView = detailView else { return }
        
        let buttonsStatus: [UIButton] = [detailView.statusHappyButton, detailView.statusNormalButton, detailView.statusSadButton]
        
        for btn in buttonsStatus {
            btn.layer.borderColor = UIColor.white.cgColor
        }
        
        switch status {
            case "normal":
            detailView.statusNormalButton.layer.borderColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6).cgColor
            case "happy":
            detailView.statusHappyButton.layer.borderColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6).cgColor
            case "sad":
            detailView.statusSadButton.layer.borderColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6).cgColor
            default:
            detailView.statusSadButton.layer.borderColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6).cgColor
        }
    }
    
    private func setupActions() {
        guard let detailView = detailView else { return }
        
        detailView.buttonSaveTextField.addTarget(self, action: #selector(saveNewRecord), for: .touchUpInside)
        detailView.buttonDelete.addTarget(self, action: #selector(deleteRecord), for: .touchUpInside)
        detailView.statusHappyButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        detailView.statusNormalButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        detailView.statusSadButton.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        detailView.buttonDoneTextField.addTarget(self, action: #selector(saveButton), for: .touchUpInside)

    }
    
    @objc func deleteRecord() {
        guard let objectID = objectID else { return }
        
        if detailView!.detailTextView.text != "" {
            do {
                let object = try context.existingObject(with: objectID)
                context.delete(object)
                try context.save()
                delegate?.updateTableView()
                self.dismiss(animated: true)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    @objc func saveButton() {
        detailView!.detailTextView.resignFirstResponder()
    }
    
    @objc private func saveNewRecord() {
        self.dismiss(animated: true)
    }
    
    @objc private func setStatus(_ sender: UIButton) {
        selectedStatus = sender.accessibilityIdentifier ?? ""
        guard let objectID = objectID else { return }
        
        do {
            let object = try context.existingObject(with: objectID)
            object.setValue(selectedStatus, forKey: "state")
            try context.save()
            delegate?.updateTableView()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let objectID = objectID else { return }
        
        if detailView!.detailTextView.text != "" {
            do {
                let object = try context.existingObject(with: objectID)
                object.setValue(detailView!.detailTextView.text, forKey: "note")
                try context.save()
                delegate?.updateTableView()
            } catch let error as NSError {
                print(error)
            }
        }
    }
}

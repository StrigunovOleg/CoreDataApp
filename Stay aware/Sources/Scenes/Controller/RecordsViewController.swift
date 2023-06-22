//
//  ViewController.swift
//  Stay aware
//
//  Created by Олег Стригунов on 24.04.2023.
//

import UIKit
import SnapKit
import CoreData


protocol UpdateTableView: AnyObject {
    func updateTableView()
}

class RecordsViewController: UIViewController {
    
    private var recordsView: RecordsView? {
        guard isViewLoaded else { return nil }
        return view as? RecordsView
    }
    
    var context: NSManagedObjectContext!
    
    var items: [Items] = []
    var dayNote: [DayModel] = []
    var days: [[DayModel]] = []
    
    var currentYear = 0 {
        // ? Почему не работает
        didSet {
            recordsView?.labelCurrentDate.text = "\(currentYear)"
            days = []
            getDateMonth()
            recordsView?.tableView.reloadData()
        }
    }
    
    var currentMonth = 11
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view = RecordsView()
        
        
        recordsView!.tableView.dataSource = self
        recordsView!.tableView.delegate = self
        
        recordsView!.collectionView.dataSource = self
        recordsView!.collectionView.delegate = self
        
        recordsView?.labelCurrentDate.text = "\(currentYear)"
        
        setupActions()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDateMonth()
        
    }
    
    
    //MARK: - Actions
    
    func setupActions() {
        guard let recordsView = recordsView else { return }
        
        recordsView.buttonNextYear.addTarget(self, action: #selector(nextYear), for: .touchUpInside)
        recordsView.buttonFastYear.addTarget(self, action: #selector(fastYear), for: .touchUpInside)
        
    }
    
    @objc private func nextYear() {
        currentYear += 1
    }
    
    @objc private func fastYear() {
        currentYear -= 1
    }
    
    private func getDateMonth() {
        // Вывод данных
        let fetchData: NSFetchRequest<Items> = Items.fetchRequest()
        fetchData.returnsObjectsAsFaults = false
        
        // вывод по придикейту, если его убрать получим все записи
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth == 12 ? currentMonth : currentMonth + 1, day: currentMonth == 12 ? 31 : 1))!
        fetchData.predicate = NSPredicate(format: "date BETWEEN {%@, %@}", startDate as NSDate, endDate as NSDate)
        
        
        do {
            items = try context.fetch(fetchData)
            
            
            for item in items {
                dayNote.append(DayModel(id: item.objectID, day: dateFormatter.string(from: item.date!), time: timeFormatter.string(from: item.date!), note: item.note!, status: item.state!))
                
            }
            
        }
        catch let error as NSError {
            printContent(error.localizedDescription)
        }
        
        
        prepareModel()
    }
    
    func prepareModel() {
        var tempArr: [DayModel] = []
        var tempDay = ""
        var tempCount = 0
        
        for item in dayNote {
            tempCount += 1
            
            if tempDay == "" {
                tempDay = item.day
            } else if tempDay != item.day {
                days.append(tempArr)
                tempArr = []
                tempDay = item.day
            }
            
            tempArr.append(item)
            
            if dayNote.count == tempCount {
                days.append(tempArr)
                continue
            }
            
        }
        
        dayNote = []
    }
    
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd"
        return df
    }()
    
    lazy var timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()
    
    lazy var monthFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM"
        return df
    }()
}

//MARK: - UITableView
extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 // Возвращает высоту 80 пунктов для всех ячеек
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? HeaderView else { return }
        
        // Установите нужные свойства для проматывания заголовка секции
        headerView.layer.zPosition = 0 // Гарантирует, что заголовок будет проматываться
        headerView.contentView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 240/255, alpha: 1.0) // Настройте цвет фона, если требуется
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as! HeaderView
        view.label.text = "\(days[section].first?.day ?? "")"
        
        return view
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordTableViewCell", for: indexPath) as? RecordTableViewCell
        
        // избавляемся от белого фона
        cell?.backgroundColor = .clear
        cell?.contentView.backgroundColor = .clear
        cell?.backgroundView = nil // Удаление фонового представления
        cell?.selectedBackgroundView = nil // Удаление фонового представления для выбранной ячейки
        cell?.selectionStyle = .none // выкл выделение при нажатиии
        
        cell?.model = days[indexPath.section][indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        detailVC.delegate = self
        
        let objectID = days[indexPath.section][indexPath.row].id
        
        detailVC.context = context
        detailVC.objectID = objectID
        self.present(detailVC, animated: true)
    }
}

//MARK: - UICollectionView
extension RecordsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: 140,
            height: 80
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowLayoutCell.indentifier, for: indexPath) as! FlowLayoutCell
        
        
        cell.isOpaque = false
        cell.layer.cornerRadius = 12
        cell.label.textAlignment = .center
        cell.label.textColor = .white
        
        var month = ""
        
        switch indexPath.row {
        case 0:
            month = "Январь"
        case 1:
            month = "Февраль"
        case 2:
            month = "Март"
        case 3:
            month = "Апрель"
        case 4:
            month = "Май"
        case 5:
            month = "Июнь"
        case 6:
            month = "Июль"
        case 7:
            month = "Август"
        case 8:
            month = "Сентябрь"
        case 9:
            month = "Октябрь"
        case 10:
            month = "Ноябрь"
        case 11:
            month = "Декабрь"
        default:
            month = ""
        }
        
        cell.label.text = month
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
        days = []
        currentMonth = indexPath.row + 1
        getDateMonth()
        recordsView!.tableView.reloadData()
        
    }
}

class FlowLayoutCell: UICollectionViewCell {
    static let indentifier = "flowLayoutCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 91/255, green: 81/255, blue: 179/255, alpha: 0.6)
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 12
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordsViewController: UpdateTableView {
    func updateTableView() {
        days = []
        getDateMonth()
        recordsView!.tableView.reloadData()
    }
}


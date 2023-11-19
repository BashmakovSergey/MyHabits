import UIKit

enum PresentVC {
    case createHabit
    case editHabit
}

final class HabitViewController: UIViewController {
    
    var currentLastVC = PresentVC.createHabit
    var delegate: UpdateCollectionViewProtocol?
    var delegate2: Callback?
    var newHabit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    let navBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.backgroundColor = .MyHabitsColor.grayWhiteColor
        return bar
    }()
    
    let navItem: UINavigationItem = {
        let itemBar = UINavigationItem()
        return itemBar
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return picker
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = .FootNoteBold
        label.numberOfLines = 1
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = .FootNote
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = .FootNoteBold
        return label
    }()
    
    lazy var colorPickerView: UIView = {
        let view = UIView()
        view.roundCornerWithRadius(15, top: true, bottom: true, shadowEnabled: false)
        view.backgroundColor = newHabit.color
        let tapColor = UITapGestureRecognizer(target: self, action: #selector(tapColorPicker))
        view.addGestureRecognizer(tapColor)
        return view
    }()
    
    private lazy var colorPickerViewController: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
//        colorPicker.supportsAlpha = false
        return colorPicker
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = .FootNoteBold
        return label
    }()
    
    lazy var habitTimeLabelText: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в"
        return label
    }()
    
    lazy var habitTimeLabelTime: UILabel = {
        let label = UILabel()
        label.text = " \(dateFormatter.string(from: datePicker.date))"
        label.tintColor = .MyHabitsColor.purpleColor
        label.textColor = .MyHabitsColor.purpleColor
        return label
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить привычку", for: .normal)
        button.tintColor = .MyHabitsColor.redColor
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstrain()
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        switch currentLastVC {
            case .createHabit: do {
                newHabit.date = datePicker.date
                }
            case .editHabit: do {
                }
        }
        habitTimeLabelTime.text = " \(dateFormatter.string(from: datePicker.date))"
    }
    
    @objc func nameTextChanged() {
        guard let result = nameTextField.text else {return}
        self.navItem.rightBarButtonItem?.isHidden = result.count == 0 ? true : false
    }
    
    @objc func tapColorPicker() {
        present(colorPickerViewController, animated: true, completion: nil)
    }
    
    @objc func actionCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func actionSaveButton() {
        switch currentLastVC {
            case .createHabit: do {
                newHabit.name = nameTextField.text ?? ""
                let store = HabitsStore.shared
                store.habits.append(newHabit)
                delegate?.reloadSlider()
                dismiss(animated: true, completion: nil)
            }
            case .editHabit: do {
                newHabit.name = nameTextField.text ?? ""
                newHabit.date = datePicker.date
                delegate?.reloadSlider()
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func deleteButtonPressed() {
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(newHabit.name)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.remove(at: HabitsStore.shared.habits.firstIndex(of: self.newHabit) ?? 0 )
            self.delegate2?.callback()
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupUI() {
        nameTextField.delegate = self
        view.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        view.addSubviews(navBar, nameLabel, nameTextField, colorLabel, colorPickerView, timeLabel, habitTimeLabelText, habitTimeLabelTime, datePicker, deleteHabitButton)
        let leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(actionCancelButton))
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.done, target: self, action: #selector(actionSaveButton))
        leftBarButtonItem.tintColor = .MyHabitsColor.purpleColor
        rightBarButtonItem.tintColor = .MyHabitsColor.purpleColor
        navItem.rightBarButtonItem = rightBarButtonItem
        navItem.leftBarButtonItem = leftBarButtonItem
        navItem.rightBarButtonItem?.isHidden = true
        navBar.setItems([navItem], animated: true)
        
        switch currentLastVC {
            case .createHabit: navItem.title = "Создать"
            case .editHabit: navItem.title = "Править"
            deleteHabitButton.isHidden = false
            navItem.rightBarButtonItem?.isHidden = false
        }

    }
    
    private func setupConstrain() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 22),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            colorPickerView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorPickerView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorPickerView.heightAnchor.constraint(equalToConstant: 30),
            colorPickerView.widthAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorPickerView.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            habitTimeLabelText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            habitTimeLabelText.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            habitTimeLabelTime.topAnchor.constraint(equalTo: habitTimeLabelText.topAnchor),
            habitTimeLabelTime.leadingAnchor.constraint(equalTo: habitTimeLabelText.trailingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: habitTimeLabelText.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        newHabit.color = colorPickerViewController.selectedColor
        colorPickerView.backgroundColor = viewController.selectedColor
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    }
    
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}


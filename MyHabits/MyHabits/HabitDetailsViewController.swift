import UIKit

protocol Callback {
    func callback()
}

final class HabitDetailViewCell: UITableViewCell {
}

final class HabitDetailsViewController: UIViewController {
    
    var habit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    private lazy var habitTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HabitDetailViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstrain()
    }
    
    @objc func editButtonPressed() {
        let viewController = HabitViewController()
        viewController.newHabit = habit
        viewController.currentLastVC = .editHabit
        viewController.nameTextField.text = habit.name
        viewController.colorPickerView.backgroundColor = habit.color
        viewController.datePicker.date = habit.date
        viewController.nameTextField.textColor = habit.color
        viewController.delegate2 = self
        navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    private func setupUI(){
        navigationController?.navigationBar.tintColor = .MyHabitsColor.purpleColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editButtonPressed))
        navigationItem.title = habit.name
        view.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        navigationController?.navigationBar.isHidden = false
        view.addSubviews(habitTableView)
    }
    
    private func setupConstrain(){
        NSLayoutConstraint.activate([
            habitTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
   
}

extension HabitDetailsViewController: UITableViewDelegate {
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countDates: Int = 0
        for date in HabitsStore.shared.dates {
            if HabitsStore.shared.habit(habit, isTrackedIn: date) {
                countDates += 1
            }
        }
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailViewCell.self), for: indexPath) as! HabitDetailViewCell
        let storeDates: [Date] = HabitsStore.shared.dates.reversed()
        cell.textLabel?.text = dateFormatter.string(from: storeDates[indexPath.row])
        if HabitsStore.shared.habit(habit, isTrackedIn: storeDates[indexPath.row]) {
            cell.accessoryType  = .checkmark
            cell.tintColor = UIColor.MyHabitsColor.purpleColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension HabitDetailsViewController: Callback {
    func callback() {
        navigationController?.popToRootViewController(animated: true)
    }
}

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var didTapOnCell: (() -> Void)?
    var habit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    private lazy var nameHabitLabel: UILabel = {
        let label = UILabel()
        label.font = .HeadLine
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .FootNote
        label.textColor = .MyHabitsColor.grayWhiteColor
        return label
    }()
    
    private lazy var trackerLabel: UILabel = {
        let label = UILabel()
        label.font = .Caption
        label.text = "Подряд: \(habit.trackDates.count)"
        label.textColor = .MyHabitsColor.grayWhiteColor
        return label
    }()
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.roundCornerWithRadius(18, top: true, bottom: true, shadowEnabled: false)
        button.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(checkBoxButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.roundCornerWithRadius(6, top: true, bottom: true, shadowEnabled: false)
        setupUI()
        setupConstrain()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstrain()
    }
    
    @objc func checkBoxButtonPressed() {
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            checkBoxButton.backgroundColor = habit.color
        }
        didTapOnCell?()
    }
    
    func configure(habit: Habit) {
        self.habit = habit
        if habit.isAlreadyTakenToday {
            checkBoxButton.backgroundColor = habit.color
        }
        nameHabitLabel.textColor = self.habit.color
        nameHabitLabel.text = self.habit.name
        dateLabel.text = self.habit.dateString
        checkBoxButton.layer.borderColor = habit.color.cgColor
        trackerLabel.text = "Подряд: \(habit.trackDates.count)"
        if habit.isAlreadyTakenToday {
            checkBoxButton.backgroundColor = habit.color
        } else {
            checkBoxButton.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        }
        
    }
    
    private func setupUI() {
        contentView.addSubviews(nameHabitLabel, dateLabel, trackerLabel, checkBoxButton)
        contentView.backgroundColor = .MyHabitsColor.whiteBackgroundColor
    }
    
    private func setupConstrain() {
        NSLayoutConstraint.activate([
            nameHabitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameHabitLabel.trailingAnchor.constraint(equalTo: checkBoxButton.leadingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: nameHabitLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: nameHabitLabel.leadingAnchor),
            
            trackerLabel.leadingAnchor.constraint(equalTo: nameHabitLabel.leadingAnchor),
            trackerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkBoxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 36),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 36),
            checkBoxButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47)
        ])
    }
    
}

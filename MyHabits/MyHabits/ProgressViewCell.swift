import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var nameHabit: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = .FootNoteStatus
        label.textColor = UIColor.MyHabitsColor.grayWhiteColor
        return label
    }()
    
    private var habitSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.setValue(HabitsStore.shared.todayProgress, animated: true)
        slider.tintColor = UIColor.MyHabitsColor.purpleColor
        return slider
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        label.font = .FootNote
        label.textColor = UIColor.MyHabitsColor.grayWhiteColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrain()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        habitSlider.setValue(HabitsStore.shared.todayProgress, animated: true)
        statusLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        contentView.backgroundColor = UIColor.MyHabitsColor.whiteBackgroundColor
        contentView.addSubviews(nameHabit, habitSlider, statusLabel)
        contentView.roundCornerWithRadius(4, top: true, bottom: true, shadowEnabled: false)
    }
    
    private func setupConstrain(){
        NSLayoutConstraint.activate([
            nameHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            habitSlider.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: 10),
            habitSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            habitSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            habitSlider.heightAnchor.constraint(equalToConstant: 7),
            habitSlider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            statusLabel.topAnchor.constraint(equalTo: nameHabit.topAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: habitSlider.trailingAnchor),
            ])
    }
    
}


import UIKit

class InfoViewController: UIViewController {

    private lazy var infoScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
       // stack.spacing = 5
        stack.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        return stack
    }()
    
    private lazy var mainHeadInfoLabel: UILabel = {
        let label = UILabel()
        label.text = infoHeadLabelText
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .MyHabitsColor.blackColor
        label.numberOfLines = 1
       // label.preferredMaxLayoutWidth = 50
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainBodyInfoLabel: UILabel = {
        let label = UILabel()
        label.text = infoBodyLabelText
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .MyHabitsColor.blackColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstrain()
    }

    private func setupUI(){
        title = "Информация"
        view.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        view.addSubview(infoScrollView)
        infoScrollView.addSubview(contentView)
        contentView.addArrangedSubview(mainHeadInfoLabel)
        contentView.addArrangedSubview(mainBodyInfoLabel)
    }
    
    private func setupConstrain(){
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            infoScrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            infoScrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            infoScrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: infoScrollView.widthAnchor),
            
            mainHeadInfoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainHeadInfoLabel.heightAnchor.constraint(equalToConstant: 40),
            //mainBodyInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainHeadInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainHeadInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            mainBodyInfoLabel.topAnchor.constraint(equalTo: mainHeadInfoLabel.bottomAnchor, constant: 16),
            mainBodyInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            mainBodyInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainBodyInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}

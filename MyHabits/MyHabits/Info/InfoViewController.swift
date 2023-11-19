import UIKit

final class InfoViewController: UIViewController {
    
    private lazy var infoModel = InfoModel()

    private lazy var infoScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    var contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .MyHabitsColor.whiteBackgroundColor
        return stack
    }()
    
    private lazy var mainHeadInfoLabel: UILabel = {
        let label = UILabel()
        label.text = infoModel.infoHeadLabelText
        label.font = .Title3
        label.textColor = .MyHabitsColor.blackColor
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var mainBodyInfoLabel: UILabel = {
        let label = UILabel()
        label.text = infoModel.infoBodyLabelText
        label.font = .Body
        label.textColor = .MyHabitsColor.blackColor
        label.numberOfLines = 0
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
        view.addSubviews(infoScrollView)
        infoScrollView.addSubviews(contentView)
        contentView.addSubviews(mainHeadInfoLabel,mainBodyInfoLabel)
    }
    
    private func setupConstrain(){
        NSLayoutConstraint.activate([
            infoScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: infoScrollView.widthAnchor),
            
            mainHeadInfoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainHeadInfoLabel.heightAnchor.constraint(equalToConstant: 40),
            mainHeadInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainHeadInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            mainBodyInfoLabel.topAnchor.constraint(equalTo: mainHeadInfoLabel.bottomAnchor, constant: 16),
            mainBodyInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            mainBodyInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainBodyInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}

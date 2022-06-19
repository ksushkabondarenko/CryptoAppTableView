import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Private
    private var nameLabel: UILabel = UILabel()
    private var costLabel: UILabel = UILabel()
    private let mainView: UIView = UIView()
    private let infoStackView: UIStackView = UIStackView()
 
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addAllSubviews()
        addConstraints()
        addSetupsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    func set(coins: CriptaClientModel) {
        nameLabel.text = coins.name ?? "None"
        costLabel.text = "$" + String(format: "%.3f", coins.priceUsd ?? "0")
    }
    
    // MARK: - Setups
    private func addAllSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(costLabel)
    }
    
    private func addConstraints() {
        //mainView
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        //infoStackView
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        infoStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12).isActive = true
    }
    
    private func addSetupsUI() {
        addCellSetUp()
        addMainViewUI()
        addInfoStackViewUI()
        nameLabelSetUp()
        costLabelSetUp()
    }
    
    private func addCellSetUp() {
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = AppColor.backgroundColor
    }
    
    private func addMainViewUI() {
        mainView.backgroundColor = AppColor.cellColor
        mainView.layer.cornerRadius = 8
    }
    
    private func addInfoStackViewUI() {
        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
        infoStackView.distribution = .fillEqually
    }
    
    private func nameLabelSetUp() {
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textAlignment = .left
    }
    
    private func costLabelSetUp() {
        costLabel.textColor = UIColor(red: 175/255, green: 173/255, blue: 185/255, alpha: 1.0)
        costLabel.textAlignment = .right
        costLabel.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

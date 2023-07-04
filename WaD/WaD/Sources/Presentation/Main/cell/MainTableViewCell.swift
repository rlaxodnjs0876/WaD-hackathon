import UIKit

import SnapKit
import Then

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"

    //MARK: - UI
    let siteAddress = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .regular)
    }

    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        makeSubviewConstraints()
        setData()
        self.contentView.backgroundColor = .white
    }
    func setData() {
            self.siteAddress.text = "https://www.op.gg/?hl=ko_KR"
        }
}

//MARK: - Layout
extension MainTableViewCell {
    private func addSubviews() {
        self.contentView.addSubview(siteAddress)
    }
    func makeSubviewConstraints() {
        siteAddress.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

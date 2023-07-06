import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var dataArray = [String]()

    //MARK: - UI
    private let siteTextField = UITextField().then {
        $0.clearButtonMode = .always
        $0.returnKeyType = .next
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.placeholder = "ex) https://----"
        $0.addLeftPadding()
    }
    private let siteText = UILabel().then {
        $0.text = "차단하고 싶은 사이트를 적어주세요."
        $0.font = .notoSansFont(ofSize: 20, family: .regular)
    }
    private let line = UIView().then {
        $0.backgroundColor = .black
    }
    private let siteListTableView = UITableView().then {
        $0.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        $0.rowHeight = 80
        $0.separatorStyle = .none
    }
    
    private let addButton = UIButton(type: .system).then {
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("추가하기", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 25, family: .medium)
        $0.contentHorizontalAlignment = .center
        $0.layer.cornerRadius = 10
    }

//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configure()
        setButton()
        self.hideKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }
    private func configure() {
        self.siteListTableView.dataSource = self
        self.siteListTableView.rowHeight = 50
        self.siteListTableView.delegate = self
    }
    private func setButton() {
        addButton.rx.tap
            .subscribe( onNext: { [ weak self ] in
                self?.dataArray.append(self?.siteTextField.text ?? "")
                self?.siteTextField.text = ""
                self?.siteListTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension MainViewController {
    func addSubviews() {
        [siteTextField,
         siteText,
         line,
         siteListTableView,
         addButton].forEach { view.addSubview($0) }
    }
    func makeSubviewConstraints() {
        siteTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(138)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        siteText.snp.makeConstraints {
            $0.top.equalTo(siteTextField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        line.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(siteText.snp.bottom).offset(82)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(38)
        }
        siteListTableView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(38)
            $0.bottom.equalToSuperview()
        }
        addButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath)
        
        cell.textLabel?.text = self.dataArray[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}

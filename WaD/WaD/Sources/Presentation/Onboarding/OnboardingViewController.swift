import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    
    private var disposeBag = DisposeBag()

//MARK: - UI
    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    private let loginButton = UIButton(type: .system).then {
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 25, family: .medium)
        $0.contentHorizontalAlignment = .center
        $0.layer.cornerRadius = 10
    }

//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackButtonToArrow()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }
    private func setButton() {
        loginButton.rx.tap
            .subscribe(onNext: { [ weak self ] in
                self?.navigationController?.pushViewController(LoginViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension OnboardingViewController {
    func addSubviews() {
        [logoImage, loginButton].forEach { view.addSubview($0) }
    }
    func makeSubviewConstraints() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(120)
            $0.width.height.equalTo(280)
        }
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
            $0.top.equalTo(logoImage.snp.bottom).offset(346)
        }
    }
}

import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    private var disposeBag = DisposeBag()

    //MARK: - UI
    private let emailText = UILabel().then {
        $0.text = "E-mail"
        $0.font = .notoSansFont(ofSize: 18, family: .regular)
    }
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요."
        $0.clearButtonMode = .always
        $0.returnKeyType = .next
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.addLeftPadding()
    }
    private let passwordText = UILabel().then {
        $0.text = "Password"
        $0.font = .notoSansFont(ofSize: 18, family: .regular)
    }
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요."
        $0.clearButtonMode = .always
        $0.returnKeyType = .next
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }
    private let loginFailedText = UILabel().then {
        $0.font = .notoSansFont(ofSize: 15, family: .regular)
        $0.textColor = .red
    }
    
    private let loginButton = UIButton(type: .system).then {
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 25, family: .medium)
        $0.contentHorizontalAlignment = .center
        $0.layer.cornerRadius = 10
    }

//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboard()
        setButton()
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
    private func setButton() {
            loginButton.rx.tap
                .subscribe(onNext: {
                    if self.emailTextField.text == "tjrgus0713@gmail.com" && self.passwordTextField.text == "qwer1234" {
                        self.navigationController?.pushViewController(MainViewController(), animated: true)
                    } else {
                        self.passwordTextField.text = ""
                        self.loginFailedText.text = "일치하지 않습니다."
                        print("일치하지 않습니다.")
                    }
                })
                .disposed(by: disposeBag)
        }
}

//MARK: - Layout
extension LoginViewController {
    func addSubviews() {
        [emailText,
         emailTextField,
         passwordText,
         passwordTextField,
         loginFailedText,
         loginButton].forEach { view.addSubview($0) }
    }
    func makeSubviewConstraints() {
        emailText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(127)
            $0.left.equalToSuperview().inset(30)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailText.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        passwordText.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(25)
            $0.left.equalToSuperview().inset(30)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordText.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        loginFailedText.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(34)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(loginFailedText.snp.bottom).offset(405)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
    }
}

import UIKit

import SnapKit
import Then

class LoginViewController: UIViewController {

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
        $0.addLeftPadding()
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }
}

//MARK: - Layout
extension LoginViewController {
    func addSubviews() {
        [emailText,
         emailTextField,
         passwordText,
         passwordTextField,
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
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(413)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
    }
}

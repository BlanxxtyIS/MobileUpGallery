//
//  ViewController.swift
//  MobileUpGallery
//
//  Created by Марат Хасанов on 13.08.2024.
//

import UIKit
import VKID

class ViewController: UIViewController {
    
    private let vkid: VKID
    private let oneTap: OneTapButton

    private lazy var appTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Mobile Up\nGallery"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.widthAnchor.constraint(equalToConstant: 227).isActive = true
        label.heightAnchor.constraint(equalToConstant: 106).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(vkid: VKID) {
        self.vkid = vkid
        self.oneTap = OneTapButton(
            appearance: .init(
                title: .get,
                style: .primary(),
                theme: .matchingColorScheme(.system)
            ),
            layout: .regular(
                height: .large(.h52),
                cornerRadius: 12
            ),
            presenter: .newUIWindow
        ) { authResult in
            switch authResult {
            case .success(let user):
                print("Авторизация успешна: \(user.accessToken)")
            case .failure(let error):
                print("Ошибка авторизации: \(error)")
            }
        }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupOneTapButton()
    }
    
    private func setupOneTapButton() {
        let oneTapView = vkid.ui(for: oneTap).uiView()
        oneTapView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appTitleLabel)
        view.addSubview(oneTapView)
        
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 126),
            appTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            oneTapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            oneTapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            oneTapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}


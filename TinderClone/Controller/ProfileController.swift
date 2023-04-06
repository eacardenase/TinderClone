//
//  ProfileController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/6/23.
//

import UIKit

class ProfileController: UIViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    private lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + 100)
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
        
        return collection
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Megan Fox - 20"
        label.numberOfLines = 0
        
        return label
    }()
    private var professionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Actress"
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    private var bioLabel: UILabel = {
        let label = UILabel()
        
        label.text = "I was in transformers"
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "dismiss_down_arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var dislikeButton: UIButton = {
        let button = createButton(withImage: UIImage(named: "dismiss_circle"))
        
        button.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var superLikeButton: UIButton = {
        let button = createButton(withImage: UIImage(named: "super_like_circle"))
        
        button.addTarget(self, action: #selector(handleSuperlike), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = createButton(withImage: UIImage(named: "like_circle"))
        
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Helpers

extension ProfileController {
    private func configureUI() {
        view.backgroundColor = .white
        
        let infoStackView = UIStackView(arrangedSubviews: [infoLabel, professionLabel, bioLabel])
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        
        let buttonsStackView = UIStackView(arrangedSubviews: [dislikeButton, superLikeButton, likeButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = -32
        
        //        collectionView.translatesAutoresizingMaskIntoConstraints = false // we don't use it in order to position it at default values (0, 0)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        view.addSubview(dismissButton)
        view.addSubview(infoStackView)
        view.addSubview(buttonsStackView)
        
        // dismissButton
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -20),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            dismissButton.widthAnchor.constraint(equalTo: dismissButton.heightAnchor)
        ])
        
        // infoStackView
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 12)
        ])
        
        // buttonsStackView
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 80),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func createButton(withImage image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }
}

// MARK: - UICollectionViewDataSource

extension ProfileController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath)
        
        if indexPath.row == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .blue
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ProfileController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegate

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Actions

extension ProfileController {
    @objc func handleDismissal() {
        dismiss(animated: true)
    }
    
    @objc func handleDislike(_ sender: UIButton) {
        
    }
    
    @objc func handleSuperlike(_ sender: UIButton) {
        
    }
    
    @objc func handleLike(_ sender: UIButton) {
        
    }
}

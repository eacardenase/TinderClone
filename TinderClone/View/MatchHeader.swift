//
//  MatchHeader.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/11/23.
//

import UIKit

protocol MatchHeaderDelegate: AnyObject {
    func matchHeader(_ header: MatchHeader, wantsToChatWith uid: String)
}

class MatchHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    weak var delegate: MatchHeaderDelegate?
    
    var matches = [Match]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let newMatchesLabel: UILabel = {
        let label = UILabel()
        
        label.text = "New Matches"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 0.9826375842, green: 0.3476698399, blue: 0.447683692, alpha: 1)
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        
        return collectionView
        
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

// MARK: - Helpers

extension MatchHeader {
    private func configureUI() {
        
        backgroundColor = .white
        
        newMatchesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MatchCell.self, forCellWithReuseIdentifier: MatchCell.reuseIdentifier)
        
        addSubview(newMatchesLabel)
        addSubview(collectionView)
        
        // newMatchesLabel
        NSLayoutConstraint.activate([
            newMatchesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            newMatchesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: newMatchesLabel.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension MatchHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchCell.reuseIdentifier, for: indexPath)
                as? MatchCell else { fatalError("Error downcasting table view cell into MatchCell") }
        
        cell.viewModel = MatchCellViewModel(match: matches[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MatchHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = matches[indexPath.item].uid
        
        delegate?.matchHeader(self, wantsToChatWith: uid)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MatchHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 108)
    }
}

//
//  MessagesController.swift
//  TinderClone
//
//  Created by Edwin Cardenas on 4/11/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class MessagesController: UITableViewController {
    
    // MARK: - Properties
    
    private let user: User
    weak var delegate: HomeNavigationStackViewDelegate?
    
    private let headerView = MatchHeader()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMatches()
        configureNavigationBar()
        configureTableView()
    }
}

// MARK: - Helpers

extension MessagesController {
    private func configureTableView() {
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none // *
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        headerView.delegate = self
    }
    
    private func configureNavigationBar() {
        let leftButton = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        
        leftButton.isUserInteractionEnabled = true
        leftButton.image = UIImage(named: "app_icon")?.withRenderingMode(.alwaysTemplate)
        leftButton.tintColor = .lightGray
        leftButton.addGestureRecognizer(tap)
        leftButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let icon = UIImageView(image: UIImage(named: "top_messages_icon")?.withRenderingMode(.alwaysTemplate))
        
        icon.tintColor = .systemPink
        
        navigationItem.titleView = icon
    }
}

// MARK: - Actions

extension MessagesController {
    @objc func handleDismissal() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MessagesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MessagesController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.9826375842, green: 0.3476698399, blue: 0.447683692, alpha: 1)
        label.text = "Messages"
        label.font = UIFont.systemFont(ofSize: 18)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
        ])
        
        return view
    }
}

// MARK: - API

extension MessagesController {
    private func fetchMatches() {
        Service.fetchMatches { matches in
            self.headerView.matches = matches
        }
    }
}

// MARK: - MatchHeaderDelegate

extension MessagesController: MatchHeaderDelegate {
    func matchHeader(_ header: MatchHeader, wantsToChatWith uid: String) {
        Service.fetchUser(withUid: uid) { user in
            print("DEBUG: Start chat with \(user.name)")
        }
    }
}

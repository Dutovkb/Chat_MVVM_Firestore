//
//  ConversationsController.swift
//  Chat_MVVM_Firestore
//
//  Created by Кирилл Дутов on 10.03.2022.
//

import UIKit

class ConversationsController: UIViewController {

    private let tableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationController()
        configureNavigationItem()
        configureTableView()
    }
    
    private func configureNavigationController() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPink
        
        if let navigationController = navigationController {
            let navigationBar = navigationController.navigationBar
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.prefersLargeTitles = true
            navigationBar.tintColor = .white
            navigationBar.isTranslucent = true
            navigationBar.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Messages"
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(showProfile))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ConversationCell")
    }
    
    @objc
    private func showProfile() {
        print("Tapped on button")
    }
}

extension ConversationsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

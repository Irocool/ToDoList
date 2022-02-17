//
//  TaskTableViewController.swift
//  ToDoList
//
//  Created by Irina Kuligina on 16.02.2022.
//

import UIKit

class TaskTableViewController: UITableViewController {

    var currentTask: Task?
    
    public var tableTasks: [Task] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        tableView.backgroundColor = .gainsboro
        tableView.register(UINib(nibName: TaskTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        
        loadTasks()
    }

    private func loadTasks() {
        if currentTask == nil { currentTask = TaskStorage.shared.getMainTask() }
        
        if let currentTask = currentTask {
            tableTasks = currentTask.openSubtasks()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func setupView() {
        view.backgroundColor = .gainsboro

        setupBarButton()
      
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            landscapeImagePhone: nil, style: .plain,
            target: self, action: #selector(addTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .gainsboro
    }
    
    @objc func addTapped() {
        self.showNewTaskAlert()
    }



// MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
    
        cell.configure(with: tableTasks[indexPath.row])
    
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TaskTableViewController") as? TaskTableViewController else { return }

        vc.currentTask = tableTasks[indexPath.row]
        vc.title = "\(tableTasks[indexPath.row].text)"
    
        navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TaskStorage.shared.removeTask(by: tableTasks[indexPath.row].id)
            tableTasks.remove(at: indexPath.row)
        }
    }
}


//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Irina Kuligina on 16.02.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var taskTextLabel: UILabel!
    public static let reuseIdentifier = "TaskTableViewCell"
    
    private var task: Task?
    
    enum ButtonState {
        case off
        case on
    }
    
    private var buttonState: ButtonState = .off {
        didSet {
            switch buttonState {
            case .off:
                checkButton.backgroundColor = .gainsboro
            case .on:
                checkButton.backgroundColor = .darkPurple
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    private func setupTaskTextLabel() {
        taskTextLabel.backgroundColor = .gainsboro
        taskTextLabel.textColor = .darkPurple
    }
    
    private func setupCheckButton() {
        checkButton.layer.masksToBounds = true
        checkButton.layer.cornerRadius = checkButton.frame.height/2
        checkButton.backgroundColor = .gainsboro
        checkButton.layer.borderColor = UIColor.darkPurple.cgColor
        checkButton.layer.borderWidth = 1.0
    }
    
    private func setupCellView() {
        self.contentView.backgroundColor = .gainsboro
        setupTaskTextLabel()
        setupCheckButton()
    }
    
    private func switchCheckButton() {
        switch buttonState {
        case .off:
            buttonState = .on
            task?.isCompleted = true
        case .on:
            buttonState = .off
            task?.isCompleted = false
        }
    }
    
    public func configure(with task: Task) {
        setupCellView()
        
        self.task = task
        taskTextLabel.text = task.text
        
        if task.isCompleted {
            buttonState = .on
        } else {
            buttonState = .off
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        guard task != nil else { return }
        switchCheckButton()
        
    }
}

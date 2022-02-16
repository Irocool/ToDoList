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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

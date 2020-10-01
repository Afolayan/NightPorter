//
//  ViewController.swift
//  NightPorter
//
//  Created by Jephthah Afolayan on 29/09/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var darkModeText: UIBarButtonItem!
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var dailyTasks = [
        Task(name: "Check all doors", type: TaskType.daily, completed: false, lastCompleted: nil),
        Task(name: "Is the boiler fueled?", type: TaskType.daily, completed: false, lastCompleted: nil),
        Task(name: "Check the mailbox", type: TaskType.daily, completed: false, lastCompleted: nil),
        Task(name: "Empty trash containers", type: TaskType.daily, completed: false, lastCompleted: nil),
        Task(name: "If freezing, check water pipes", type: TaskType.daily, completed: false, lastCompleted: nil),
        Task(name: "Document \"strange and unusual\" occurrences", type: TaskType.daily, completed: false, lastCompleted: nil),
    ]
    
    var weeklyTasks = [
        Task(name: "Check inside all cabins", type: TaskType.weekly, completed: false, lastCompleted: nil),
        Task(name: "Flush all lavatories in cabins", type: TaskType.weekly, completed: false, lastCompleted: nil),
        Task(name: "Walk the perimeter of the property", type: TaskType.weekly, completed: false, lastCompleted: nil),
    ]
    
    var monthlyTasks = [
        Task(name: "Test security alarm", type: TaskType.monthly, completed: false, lastCompleted: nil),
        Task(name: "Test motion detectors", type: TaskType.monthly, completed: false, lastCompleted: nil),
        Task(name: "Test smoke alarms", type: TaskType.monthly, completed: false, lastCompleted: nil)
    ]
    
    
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        let mySwitch = sender as! UISwitch
        if mySwitch.isOn {
            view.backgroundColor = UIColor.darkGray
            darkModeText.isEnabled = true
        } else {
            view.backgroundColor = UIColor.white
            darkModeText.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // set backgrounf to transparent
        tableView.backgroundColor = UIColor.clear
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Daily Tasks"
        case 1:
            return "Weekly Tasks"
        case 2:
            return "Monthly Tasks"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dailyTasks.count
        case 1:
            return weeklyTasks.count
        case 2:
            return monthlyTasks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)

        var currentTask: Task!
        switch indexPath.section {
        case 0:
            currentTask = dailyTasks[indexPath.row]
        case 1:
            currentTask = weeklyTasks[indexPath.row]
        case 2:
            currentTask = monthlyTasks[indexPath.row]
        default:
            cell.textLabel?.text = "This should never happen"
        }
        
        cell.textLabel?.text = currentTask.name
        cell.detailTextLabel?.text = "Completed: \(currentTask.completed)"
        if currentTask.completed {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        } else {
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row \(indexPath.row) in section \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { (action: UIContextualAction, sourceUIView: UIView, actionPerformed: (Bool)->Void) in
            
            switch indexPath.section {
            case 0:
                self.dailyTasks[indexPath.row].completed = true
            case 1:
                self.weeklyTasks[indexPath.row].completed = true
            case 2:
                self.monthlyTasks[indexPath.row].completed = true
            default:
                break
            }
            tableView.reloadData()
            actionPerformed(true)
        }
        
        let uncompleteAction = UIContextualAction(style: .destructive, title: "Uncomplete") { (action: UIContextualAction, sourceUIView: UIView, actionPerformed: (Bool)->Void) in
            
            switch indexPath.section {
            case 0:
                self.dailyTasks[indexPath.row].completed = false
            case 1:
                self.weeklyTasks[indexPath.row].completed = false
            case 2:
                self.monthlyTasks[indexPath.row].completed = false
            default:
                break
            }
            tableView.reloadData()
            actionPerformed(true)
        }
        
        
        return UISwipeActionsConfiguration(actions: [completeAction, uncompleteAction])
    }
    
    @IBAction func resetList(_ sender: Any) {
        
        let confirmAlert = UIAlertController(title: "Are you sure?", message: "Really reset the list", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            
            for i in 0..<self.dailyTasks.count {
                self.dailyTasks[i].completed = false
            }
            for i in 0..<self.weeklyTasks.count {
                self.weeklyTasks[i].completed = false
            }
            for i in 0..<self.monthlyTasks.count {
                self.monthlyTasks[i].completed = false
            }
            
            self.taskTableView.reloadData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) {
            action in
            print("That was a close one!")
        }
        
        // add actions to alert controller
        confirmAlert.addAction(yesAction)
        confirmAlert.addAction(noAction)
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}


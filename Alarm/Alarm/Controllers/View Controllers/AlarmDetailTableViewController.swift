//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Sean Jones on 3/2/20.
//  Copyright © 2020 Sean Jones. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: OUTLETS
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
   //MARK: ACTIONS
    
    @IBAction func enableButtonTapped(_ sender: Any) {
    }
    
    @IBAction func savebuttonTapped(_ sender: Any) {
        
        guard let alarmName = alarmNameTextField.text, alarmName != "" else{return}
        if let alarm = alarm{
            let date = datePicker.date
            AlarmController.sharedInstance.Update(alarm: alarm, fireDate: date, name: alarmName, enabled: self.alarmIsOn)
        }else{
            
            AlarmController.sharedInstance.addAlarm(fireDate: datePicker.date, name: alarmName, enabled: self.alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    //MARK: PROPERTIES

    
    var alarm: Alarm?
    var alarmIsOn: Bool{
        
        alarm?.isEnabled ?? true
    }
     func updateViews(){
        guard let alarm = alarm else { return }
        datePicker.setDate(alarm.date, animated: true)
        alarmNameTextField.text = alarm.alarmName
        enableButton.isEnabled = alarm.isEnabled
                }
            
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    //MARK: ACTION

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

   

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

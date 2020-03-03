//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Sean Jones on 3/2/20.
//  Copyright © 2020 Sean Jones. All rights reserved.
//

import UIKit


protocol SwitchTableViewCellDelegate: class{
    
    func switchCellSwitchValueChanged(for cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    
    //MARK: OUTLETS
    var alarm: Alarm?{
        didSet{
            updateViews()
        }
    }
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: PROPERTIES-
    
   weak var delegate: SwitchTableViewCellDelegate?
    
//MARK: ACTIONS
    
    @IBAction func DatePickerChanged(_ sender: Any) {
        
      
        
       
    }
    @IBAction func switchValueChanged(_ sender: Any) {
        
        delegate?.switchCellSwitchValueChanged(for: self)
    }
    
    
    func updateViews(){
        
        guard let alarm = alarm else{return}
        timeLabel.text = alarm.fireTime
        nameLabel.text = alarm.alarmName
        alarmSwitch.isOn = alarm.isEnabled
        
        
            
        
    }
    
}

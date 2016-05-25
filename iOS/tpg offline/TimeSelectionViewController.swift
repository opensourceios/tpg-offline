//
//  TimeSelectionViewController.swift
//  tpg offline
//
//  Created by Rémy Da Costa Faro on 16/01/2016.
//  Copyright © 2016 dacostafaro. All rights reserved.
//

import UIKit
import SwiftyJSON
import ChameleonFramework
import FontAwesomeKit
import EFCircularSlider

class TimeSelectionViewController: UIViewController {
    @IBOutlet weak var hourSlider: EFCircularSlider!
    @IBOutlet weak var minuteSlider: EFCircularSlider!
    @IBOutlet weak var boutonValider: UIButton!
    @IBOutlet weak var labelHeure: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourSlider.innerMarkingLabels = (["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "0"])
        hourSlider.labelFont = UIFont.systemFontOfSize(12)
        hourSlider.handleType = CircularSliderHandleTypeBigCircle
        
        view.addSubview(hourSlider)
        hourSlider.addTarget(self, action: #selector(TimeSelectionViewController.hourChanged(_:)), forControlEvents: .ValueChanged)
        
        minuteSlider.innerMarkingLabels = (["5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "0"])
        minuteSlider.labelFont = UIFont.systemFontOfSize(10)
        minuteSlider.handleType = CircularSliderHandleTypeBigCircle
        view.addSubview(minuteSlider)
        
        minuteSlider.addTarget(self, action: #selector(TimeSelectionViewController.minuteChanged(_:)), forControlEvents: .ValueChanged)
        
        if ActualRoutes.route.date != nil {
            hourSlider.currentValue = Float(ActualRoutes.route.date!.hour)
            minuteSlider.currentValue = Float(ActualRoutes.route.date!.minute)
            labelHeure.text = NSDateFormatter.localizedStringFromDate(NSCalendar.currentCalendar().dateFromComponents(ActualRoutes.route.date!)!, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        }
        
        minuteSlider.unfilledColor = AppValues.primaryColor.darkenByPercentage(0.1)
        minuteSlider.filledColor = AppValues.primaryColor.lightenByPercentage(0.2)
        hourSlider.unfilledColor = AppValues.primaryColor.lightenByPercentage(0.1)
        hourSlider.filledColor = AppValues.primaryColor.darkenByPercentage(0.2)
        hourSlider.labelColor = AppValues.textColor
        minuteSlider.labelColor = AppValues.textColor
        view.backgroundColor = AppValues.primaryColor
        labelHeure.textColor = AppValues.textColor
        minuteSlider.handleColor = minuteSlider.filledColor
        hourSlider.handleColor = hourSlider.filledColor
        
        boutonValider.backgroundColor = AppValues.secondaryColor
        boutonValider.setTitle("Valider", forState: .Normal)
        boutonValider.setTitleColor(AppValues.textColor, forState: .Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshTheme()
        
        boutonValider.backgroundColor = AppValues.secondaryColor
        boutonValider.setTitleColor(AppValues.textColor, forState: .Normal)
        minuteSlider.unfilledColor = AppValues.primaryColor.darkenByPercentage(0.1)
        minuteSlider.filledColor = AppValues.primaryColor.lightenByPercentage(0.2)
        hourSlider.unfilledColor = AppValues.primaryColor.lightenByPercentage(0.1)
        hourSlider.filledColor = AppValues.primaryColor.darkenByPercentage(0.2)
        hourSlider.labelColor = AppValues.textColor
        minuteSlider.labelColor = AppValues.textColor
        view.backgroundColor = AppValues.primaryColor
        labelHeure.textColor = AppValues.textColor
        minuteSlider.handleColor = minuteSlider.filledColor
        hourSlider.handleColor = hourSlider.filledColor
    }
    func minuteChanged(sender: AnyObject!) {
        labelHeure.text = NSDateFormatter.localizedStringFromDate(NSCalendar.currentCalendar().dateFromComponents(ActualRoutes.route.date!)!, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        if ActualRoutes.route.date == nil {
            ActualRoutes.route.date = NSCalendar.currentCalendar().components([.Day, .Month, .Year, .Hour, .Minute], fromDate: NSDate())
            ActualRoutes.route.date!.hour = 0
        }
        ActualRoutes.route.date!.minute = Int(minuteSlider.currentValue)
    }
    func hourChanged(sender: AnyObject!) {
        labelHeure.text = NSDateFormatter.localizedStringFromDate(NSCalendar.currentCalendar().dateFromComponents(ActualRoutes.route.date!)!, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        if ActualRoutes.route.date == nil {
            ActualRoutes.route.date = NSCalendar.currentCalendar().components([.Day, .Month, .Year, .Hour, .Minute], fromDate: NSDate())
            ActualRoutes.route.date!.minute = 0
        }
        ActualRoutes.route.date!.hour = Int(hourSlider.currentValue)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        hourSlider.setNeedsLayout()
        minuteSlider.setNeedsLayout()
    }
    
    @IBAction func boutonValiderPressed(sender: AnyObject!) {
        navigationController?.popViewControllerAnimated(true)
    }
}
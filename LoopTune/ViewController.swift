//
//  ViewController.swift
//  LoopTune
//
//  Created by Rick Street on 5/4/15.
//  Copyright (c) 2015 Rick Street. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var process = Process()
    var flagSecondOrder: Bool = false
    var flagIntegragtor: Bool = false
    var activeTextField: UITextField?
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var labelProcessType: UILabel!
    
    @IBOutlet weak var textTau1: UITextField!
    
    @IBOutlet weak var textTau2: UITextField!
    @IBOutlet weak var labelTau2: UILabel!
    @IBOutlet weak var labelDeadTime: UILabel!
    @IBOutlet weak var textDeadTime: UITextField!

    @IBOutlet weak var labelDeltaCV: UILabel!
    @IBOutlet weak var textDeltaCV: UITextField!
    @IBOutlet weak var labelDeltaMV: UILabel!
    @IBOutlet weak var textDeltaMV: UITextField!
    
    @IBOutlet weak var textDeltaTime: UITextField!

    @IBOutlet weak var textCV0: UITextField!
    @IBOutlet weak var textCV100: UITextField!
    @IBOutlet weak var textMV0: UITextField!
    @IBOutlet weak var textMV100: UITextField!
    
    
    @IBOutlet weak var labelKp: UILabel!
    @IBOutlet weak var textKp: UITextField!
    
    @IBOutlet weak var labelRampKp: UILabel!
    @IBOutlet weak var textRampKp: UITextField!
    
    @IBOutlet weak var textClosedTimeConstant: UITextField!

    @IBOutlet weak var labelDerivativeTime: UILabel!
    @IBOutlet weak var labelDerivativeTimeValue: UILabel!
    
    @IBOutlet weak var textLabelKp: UILabel!
    @IBOutlet weak var textLabelKpScaled: UILabel!
    
    @IBOutlet weak var labelClosedtoOpen: UILabel!
    @IBOutlet weak var labelControllerMaxGain: UILabel!
    @IBOutlet weak var labelKpKc: UILabel!
    
    @IBOutlet weak var labelUncontrolParam: UILabel!
    
    @IBOutlet weak var labelControllerGain: UILabel!
    @IBOutlet weak var labelControllerIntegralTime: UILabel!
    
    @IBOutlet weak var labelControllerDerivativeTime: UILabel!
    
    var processGainEU: Double?
        {
        get
        {
            print("got processGainEU")
            if flagIntegragtor {
                return NSNumberFormatter().numberFromString(textRampKp.text!) as Double?
            } else {
                return NSNumberFormatter().numberFromString(textKp.text!) as Double?
            }
        }
        set
        {
            if let result = newValue {
                textLabelKp.text = "\(result)"
            } else {
                textLabelKp.text = nil
            }
            // println("set textKp.text: \(textLabelKp.text)")
        }
    }
 
    var processGainScaled: Double? {
        get {
            return NSNumberFormatter().numberFromString(textLabelKpScaled.text!) as Double?
        }
        set {
            if let result = newValue {
                textLabelKpScaled.text = "\(result)"
            } else {
                textLabelKpScaled.text = nil
            }
        }
    }
    
    
    var cvLoRange: Double? {
        get {
            // println("got CV0")
            return NSNumberFormatter().numberFromString(textCV0.text!) as Double?
        }
        set {
            if let result = newValue {
                textCV0.text = "\(result)"
            } else {
                textCV0.text = nil
            }
            // println("set textKp.text: \(textCV0.text)")
        }
    }
    
    var cvHiRange: Double? {
        get {
            return NSNumberFormatter().numberFromString(textCV100.text!) as Double?
        }
        set {
            if let result = newValue {
                textCV100.text = "\(result)"
            } else {
                textCV100.text = nil
            }
             // println("set CV100.text: \(textCV0.text)")
        }
    }

    
    var mvLoRange: Double? {
        get {
            return NSNumberFormatter().numberFromString(textMV0.text!) as Double?
        }
        set {
            if let result = newValue {
                textMV0.text = "\(result)"
            } else {
                textMV0.text = nil
            }
            // println("set MV0.text: \(textCV0.text)")
        }
    }
    
    
    var mvHiRange: Double? {
        get {
            return NSNumberFormatter().numberFromString(textMV100.text!) as Double?
        }
        set {
            if let result = newValue {
                textMV100.text = "\(result)"
            } else {
                textMV100.text = nil
            }
            // println("set MV100.text: \(textMV100.text)")
        }
    }

    var deltaCV: Double? {
        get {
            // println("got MV100")
            return NSNumberFormatter().numberFromString(textDeltaCV.text!) as Double?
        }
        set {
            if let result = newValue {
                textDeltaCV.text = "\(result)"
            } else {
                textDeltaCV.text = nil
            }
            // println("set MV100.text: \(textMV100.text)")
        }
    }
    
    var deltaMV: Double? {
        get {
            // println("got MV100")
            return NSNumberFormatter().numberFromString(textDeltaMV.text!) as Double?
        }
        set {
            if let result = newValue {
                textDeltaMV.text = "\(result)"
            } else {
                textDeltaMV.text = nil
            }
            // println("set MV100.text: \(textMV100.text)")
        }
    }

    var deltaTime: Double? {
        get {
            // println("got MV100")
            return NSNumberFormatter().numberFromString(textDeltaTime.text!) as Double?
        }
        set {
            if let result = newValue {
                textDeltaTime.text = "\(result)"
            } else {
                textDeltaTime.text = nil
            }
            // println("set MV100.text: \(textMV100.text)")
        }
    }
    
    
    var processTimeConstant: Double? {
        get {
            return NSNumberFormatter().numberFromString(textTau1.text!) as Double?
        }
        set {
            if let result = newValue {
                textTau1.text = "\(result)"
            } else {
                textTau1.text = nil
            }
        }
    }

    
    var processSecondTimeConstant: Double? {
        get {
            return NSNumberFormatter().numberFromString(textTau2.text!) as Double?
        }
        set {
            if let result = newValue {
                textTau2.text = "\(result)"
            } else {
                textTau2.text = nil
            }
        }
    }
    
    var processDeadTime: Double? {
        get {
            return NSNumberFormatter().numberFromString(textDeadTime.text!) as Double?
        }
        set {
            if let result = newValue {
                textDeadTime.text = "\(result)"
            } else {
                textDeadTime.text = nil
            }
        }
    }
    
    var closedLoopTimeConstant: Double? {
        get {
            return NSNumberFormatter().numberFromString(textClosedTimeConstant.text!) as Double?
        }
        set {
            if let result = newValue {
                textClosedTimeConstant.text = "\(result)"
            } else {
                textClosedTimeConstant.text = nil
            }
        }
    }

    var controllerGain: Double? {
        get {
            return NSNumberFormatter().numberFromString(textDeadTime.text!) as Double?
        }
        set {
            if let result = newValue {
                labelControllerGain.text = String(format: "%.5f", result)
            } else {
                labelControllerGain.text = "  "
            }
        }
    }
    
    var controllerMaxGain: Double? {
        get {
            return NSNumberFormatter().numberFromString(textDeadTime.text!) as Double?
        }
        set {
            if let result = newValue {
                labelControllerMaxGain.text = String(format: "%.5f", result)
            } else {
                labelControllerMaxGain.text = "  "
            }
        }
     }
    
    var gainKpKc: Double? {
        get {
            return NSNumberFormatter().numberFromString(textDeadTime.text!) as Double?
        }
        set {
            if let result = newValue {
                labelKpKc.text = String(format: "%.5f", result)
            } else {
                labelKpKc.text = "  "
            }
        }
    }
    
    var controllerIntegralTime: Double? {
        get {
            return NSNumberFormatter().numberFromString(textDeadTime.text!) as Double?
        }
        set {
            if let result = newValue {
                labelControllerIntegralTime.text = String(format: "%.5f", result)
            } else {
                labelControllerIntegralTime.text = "  "
            }
        }
    }
    
    
    var controllerDerivativeTime: Double? {
        get {
            return NSNumberFormatter().numberFromString(textDeadTime.text!) as Double?
        }
        set {
            if let result = newValue {
                labelControllerDerivativeTime.text = String(format: "%.5f", result)
            } else {
                labelControllerDerivativeTime.text = "  "
            }
        }
     }
    
    
    var closedToOpenTimeConstantRatio: Double? {
        get {
            return NSNumberFormatter().numberFromString(textDeadTime.text!) as Double?
        }
        set {
            if let result = newValue {
                labelClosedtoOpen.text = String(format: "%.5f", result)
            } else {
                labelClosedtoOpen.text = "  "
            }
        }
    }
    
   


    @IBAction func selectProcessType(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        process.processType = process.processTypes[title]!
        labelProcessType.text = process.processType.description
        displayControllerParams()
        switch title {
        case "FOWDT":
            secondOrder(false)
            deadTime(true)
            intetrator(false)
        case "SO":
            secondOrder(true)
            intetrator(false)
            deadTime(false)
        case "SOWDT":
            secondOrder(true)
            deadTime(true)
            intetrator(false)
        case "LFO":
            secondOrder(false)
            intetrator(true)
            deadTime(false)
        case "I":
            secondOrder(false)
            intetrator(true)
            deadTime(false)
        case "IFO":
            secondOrder(false)
            intetrator(true)
            deadTime(false)
        case "IFOWDT":
            secondOrder(false)
            intetrator(true)
            deadTime(true)
        default:
            print("Unknown")
        }
    }
    
    @IBAction func selectControlMode(sender: AnyObject) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        process.controlMode = process.controlModes[title!]!
        displayControllerParams()
        if title == "PID" {
            labelDerivativeTime.textColor = UIColor.blackColor()
            labelDerivativeTimeValue.textColor = oceanColor
        } else {
            labelDerivativeTime.textColor = UIColor.lightGrayColor()
            labelDerivativeTimeValue.textColor = UIColor.lightGrayColor()
        }
    }

    
    @IBAction func selectControllerType(sender: UISegmentedControl) {
        let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        process.controllerType = process.controllerTypes[title!]!
        displayControllerParams()
    }

    func secondOrder (secondOrder: Bool) {
        if secondOrder {
            labelTau2.textColor = UIColor.blackColor()
            textTau2.enabled = true
           flagSecondOrder = true
        } else {
            labelTau2.textColor = UIColor.lightGrayColor()
            textTau2.enabled = false
            flagSecondOrder = false
        }
    }
    
    func deadTime (deadTime: Bool) {
        if deadTime {
            labelDeadTime.enabled = true
            textDeadTime.textColor = UIColor.blackColor()
        } else {
            labelDeadTime.enabled = false
            textDeadTime.textColor = UIColor.lightGrayColor()        }
    }

    func intetrator (integrator: Bool) {
        if integrator {
            // labelRampKp.textColor = UIColor.blackColor()
            // textRampKp.textColor = UIColor.blackColor()
            // textRampKp.borderStyle = UITextBorderStyle.RoundedRect
            labelRampKp.hidden = false
            textRampKp.hidden = false
            labelRampKp.textColor = UIColor.lightGrayColor()
            textRampKp.textColor = UIColor.lightGrayColor()
            labelDeltaCV.text = "∆CV at Max Slope (EU)"
            labelDeltaMV.text = "∆MV at Max Slope (EU)"
            labelKp.text = "∆Time for Change"
            labelKp.textColor = UIColor.blackColor()
            textKp.hidden = true
            textKp.enabled = false
            textDeltaTime.hidden = false
            textDeltaTime.enabled = true
            flagIntegragtor = true
            
        } else {
            labelRampKp.hidden = true
            textRampKp.hidden = true
            // labelRampKp.textColor = UIColor.clearColor()
            // textRampKp.textColor = UIColor.clearColor()
            // textRampKp.borderStyle = UITextBorderStyle.None
            labelDeltaCV.text = "∆CV (EU)"
            labelDeltaMV.text = "∆MV (EU)"
            labelKp.text = "Process Gain (Kp) (EU)"
            labelKp.textColor = UIColor.lightGrayColor()
            textKp.hidden = false
            textKp.enabled = true
            textDeltaTime.hidden = true
            textDeltaTime.enabled = false
            flagIntegragtor = false
        }
    }

    @IBAction func enterKp(sender: UITextField) {
        labelDeltaCV.textColor = UIColor.lightGrayColor()
        textDeltaCV.textColor = UIColor.whiteColor()
        labelDeltaMV.textColor = UIColor.lightGrayColor()
        textDeltaMV.textColor = UIColor.whiteColor()
        process.deltaCV = nil
        process.deltaMV = nil
        process.deltaTime = nil
        if flagIntegragtor {
            labelKp.textColor = UIColor.lightGrayColor()
            textKp.textColor = UIColor.whiteColor()
            textRampKp.textColor = UIColor.blackColor()
            labelRampKp.textColor = UIColor.blackColor()
        } else {
            labelKp.textColor = UIColor.blackColor()
            textKp.textColor = UIColor.blackColor()
        }
    }

    @IBAction func finishEnterKp(sender: UITextField) {
        print("getting processGainEU")
        process.processGainEU = processGainEU
        process.calcProcessGain()
        process.calcTuningParams()
        processGainEU = process.processGainEU
        processGainScaled = process.processGainScaled
    }
    
    @IBAction func enterDeltasForKp(sender: UITextField) {
        labelDeltaCV.textColor = UIColor.blackColor()
        textDeltaCV.textColor = UIColor.blackColor()
        labelDeltaMV.textColor = UIColor.blackColor()
        textDeltaMV.textColor = UIColor.blackColor()
        textKp.textColor = UIColor.whiteColor()
        process.processGainEU = nil
        if flagIntegragtor {
            labelKp.textColor = UIColor.blackColor()
            textRampKp.textColor = UIColor.lightGrayColor()
            labelRampKp.textColor = UIColor.lightGrayColor()

        } else {
            labelKp.textColor = UIColor.lightGrayColor()
        }
      }

    @IBAction func finishEnterDeltasForKp(sender: UITextField) {
        process.cvLoRange = cvLoRange
        process.cvHiRange = cvHiRange
        process.mvLoRange = mvLoRange
        process.mvHiRange = mvHiRange
        process.deltaCV = deltaCV
        process.deltaMV = deltaMV
        process.deltaTime = deltaTime
        process.calcProcessGain()
        process.calcTuningParams()
        processGainEU = process.processGainEU
        processGainScaled = process.processGainScaled
    }
    
    
    @IBAction func didEnterDynamics(sender: UITextField) {
        process.processTimeConstant = processTimeConstant
        process.processSecondTimeConstant = processSecondTimeConstant
        process.processDeadTime = processDeadTime
        displayControllerParams()
    }
        
    @IBAction func didEnterClosedTimeConstant(sender: UITextField) {
        process.closedLoopTimeConstant = closedLoopTimeConstant
        displayControllerParams()
    }
    
        
    let oceanColor = UIColor(red: 0, green: 64/255, blue: 128/255, alpha: 1)

    func displayControllerParams() {
        process.calcTuningParams()
        closedToOpenTimeConstantRatio = process.closedToOpenTimeConstantRatio
        controllerMaxGain = process.controllerMaxGain
        gainKpKc = process.gainKpKc
        controllerGain = process.controllerGain
        controllerIntegralTime = process.controllerIntegralTime
        controllerDerivativeTime = process.controllerDerivativeTime
    }
    
    // MARK: Code to show and hide keyboard
    
    // ViewController Override Func's
    
    // register keyboard noficications
    // Must set delegate in a method
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        // Set TextField Delegates
        textTau2.delegate = self
        textDeadTime.delegate = self
        textDeltaCV.delegate = self
        textDeltaMV.delegate = self
        textDeltaTime.delegate = self
        textKp.delegate = self
        textRampKp.delegate = self
        textTau1.delegate = self
        // textClosedTimeConstant.delegate = self
        textCV0.delegate = self
        textCV100.delegate = self
        textMV0.delegate = self
        textMV100.delegate = self
    }
   
    
    // Add tap gester to scrollView to dismiss keyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Set up Tag Gesture to dismiss keyboard before loading VC
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        scrollView.addGestureRecognizer(recognizer)
        labelDerivativeTime.textColor = UIColor.lightGrayColor()
        labelDerivativeTimeValue.textColor = UIColor.lightGrayColor()
        
        // set initial controller configuration
        process.processType = process.processTypes["FOWDT"]!
        process.controlMode = process.controlModes["PI"]!
        process.controllerType = process.controllerTypes["Parallel"]!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // func to handle tap and dismiss keyboard by releasing first responder
    func handleTap(recognizer: UITapGestureRecognizer) {
        if let aField = activeTextField {
            aField.resignFirstResponder()
        }
    }
    
    // Remove keyboard noficiations
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    //MARK: - UITextField Delegate Methods
    
    // Delegate func: Sets activeTextField
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
        // scrollView.scrollEnabled = true
    }
    
    // Delegate func:
    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
        // scrollView.scrollEnabled = false
    }
    
    // Delegate func: Dismisses keyboard when return key hit
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    //MARK: - Keyboard Management Methods
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        if let activeTextFieldRect: CGRect? = activeTextField?.frame {
            if let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin {
                if (!CGRectContainsPoint(aRect, activeTextFieldOrigin!)) {
                    scrollView.scrollRectToVisible(activeTextFieldRect!, animated:true)
                }
            }
        }
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

}


//
//  Process.swift
//  
//
//  Created by Rick Street on 4/27/15.
//
//

import Foundation

class Process {
    
    
    enum ProcessType: String {
        case FOWDT = "FOWDT"
        case SO = "SO"
        case SOWDT = "SOWDT"
        case LFO = "LFO"
        case I = "I"
        case IFO = "IFO"
        case IFOWDT = "IFOWDT"
        
        var description: String {
            get {
                switch self {
                case .FOWDT:
                    return "First Order with Dead Time"
                case .SO:
                    return "Second Order"
                case .SOWDT:
                    return "Second Order with Dead Time"
                case .LFO:
                    return "Long Time Constant with Dead Time"
                case .I:
                    return "Integrating"
                case .IFO:
                    return "Integrating First Order"
                case IFOWDT:
                    return "Integrating First Order with Dead Time"
                }
            }
        }
        var integrator: Bool {
            switch self {
            case .LFO:
                return true
            case .I:
                return true
            case .IFOWDT:
                return true
            default:
                return false
            }
        }
    }

    enum ControlMode: String {
        case PI = "PI"
        case PID = "PID"
    }
    
    enum ControllerType: String {
        case Parallel = "Parallel"
        case Series = "Series"
    }
    
    var processTypes = [String: ProcessType]()
    var controlModes = [String: ControlMode]()
    var controllerTypes = [String: ControllerType]()
    
    
    var processType: ProcessType = ProcessType.FOWDT
    var controlMode: ControlMode = ControlMode.PI
    var controllerType: ControllerType = ControllerType.Parallel
    
    var cvLoRange: Double?
    var cvHiRange: Double?
    var mvLoRange: Double?
    var mvHiRange: Double?
    
    var deltaCV: Double?
    var deltaMV: Double?
    var deltaTime: Double?
    var processGainEU: Double?
    var processGainScaled: Double?

    var processTimeConstant: Double?
    var processSecondTimeConstant: Double?
    var processDeadTime: Double?
    
    var controllerGain: Double?
    
    var controllerMaxGain: Double?
    
    var gainKpKc: Double?

    var controllerIntegralTime: Double?
    var controllerDerivativeTime: Double?
    var controllerFilter: Double?
    var controllerSetpointFilter: Double?
    var closedLoopTimeConstant: Double?
    var closedToOpenTimeConstantRatio: Double?
    var uncontrollabilityParam: Double?
    
    
    
    func calcProcessGain () {
        if let _ = processGainEU {
            // use Kp
        } else {
            // use Delta's
            if let dCV = deltaCV {
                print("DeltaCV \(deltaCV)")
                if let dMV = deltaMV {
                    print("DeltaMV \(deltaMV)")
                    if processType.integrator {
                        // Integrator
                        print("Intetrator")
                        if let dTime = deltaTime {
                            print("DeltaTime \(deltaTime)")
                            processGainEU = dCV / (dMV * dTime)
                        }
                    } else {
                        // Regular
                        print("Regular")
                        processGainEU = dCV / dMV
                    }
                }
            }
        }
        if let KpEU = processGainEU {
            if let cvLo = cvLoRange {
                if let cvHi = cvHiRange {
                    if let mvLo = mvLoRange {
                        if let mvHi = mvHiRange {
                            processGainScaled = KpEU * (cvHi - cvLo) / (mvHi - mvLo)
                        }
                    }
                }
            }
        }
    }

    func calcTuningParams() {
        print("Kp: \(processGainEU)")
        print("Kp EU: \(processGainScaled)")
        print("Tau 1: \(processTimeConstant)")
        print("Tau 2: \(processSecondTimeConstant)")
        print("Dead Time: \(processDeadTime)")
        if let lamda = closedLoopTimeConstant {
            if let tau = processTimeConstant {
                closedToOpenTimeConstantRatio = lamda / tau
                print("lamda \(lamda)  tau \(tau)")
                print("Lamda / Tau: \(closedToOpenTimeConstantRatio)")
            }
        } else {
            closedToOpenTimeConstantRatio = nil
        }
        switch processType {
        case .FOWDT:
            print("First Order with Deadtime")
            if let kp = processGainScaled {
                print("Have kp \(kp)")
                if let tau1 = processTimeConstant {
                    print("Have Tau \(tau1)")
                    if let dt = processDeadTime {
                        print("Have Dead Time \(dt)")
                        if let tauClosed = closedLoopTimeConstant {
                            print("Have lamda \(tauClosed)")
                            switch controlMode {
                            case .PID:
                                print("PID")
                                let kc = (1/kp) * tau1 / (tauClosed + dt)
                                let ti = tau1
                                let td = dt/2
                                switch controllerType {
                                case .Parallel:
                                    print("Parallel")
                                    controllerGain = kc * (1 + td / ti)
                                    controllerIntegralTime = ti * (1 + td / ti)
                                    controllerDerivativeTime = td / (1 + td / ti)
                                    print("Tuning: \(controllerGain) \(controllerIntegralTime) \(controllerDerivativeTime)")
                                case .Series:
                                    print("Series")
                                    controllerGain = kc
                                    controllerIntegralTime = ti
                                    controllerDerivativeTime = td
                                    print("Tuning: \(controllerGain) \(controllerIntegralTime) \(controllerDerivativeTime)")
                                }
                            case .PI:
                                print("PI")
                                let kc = (1/kp) * tau1 / (tauClosed)
                                let ti = tau1
                                controllerGain = kc
                                controllerIntegralTime = ti
                                controllerDerivativeTime = nil
                            }

                        }
                    }
                }
            } else {
                controllerGain = nil
                controllerIntegralTime = nil
                controllerDerivativeTime = nil
            }

        case .SO:
            print("Second Order")
            switch controlMode {
            case .PID:
                print("PID")
                switch controllerType {
                case .Parallel:
                    print("Parallel")
                case .Series:
                    print("Series")
                }
            case .PI:
                print("PI")
            }
        case .SOWDT:
            print("Second Order with Deadtime")
            switch controlMode {
            case .PID:
                print("PID")
                switch controllerType {
                case .Parallel:
                    print("Parallel")
                case .Series:
                    print("Series")
                }
            case .PI:
                print("PI")
            }
        case .LFO:
            print("Long Time Constant with Deadtime")
            switch controlMode {
            case .PID:
                print("PID")
                switch controllerType {
                case .Parallel:
                    print("Parallel")
                case .Series:
                    print("Series")
                }
            case .PI:
                print("PI")
            }
        case .I:
            print("Integrator")
            switch controlMode {
            case .PID:
                print("PID")
                switch controllerType {
                case .Parallel:
                    print("Parallel")
                case .Series:
                    print("Series")
                }
            case .PI:
                print("PI")
            }
        case .IFO:
            print("Integrator First Order")
            switch controlMode {
            case .PID:
                print("PID")
                switch controllerType {
                case .Parallel:
                    print("Parallel")
                case .Series:
                    print("Series")
                }
            case .PI:
                print("PI")
            }
        case .IFOWDT:
            print("Integrator First Order with Deadtime")
            switch controlMode {
            case .PID:
                print("PID")
                switch controllerType {
                case .Parallel:
                    print("Parallel")
                case .Series:
                    print("Series")
                }
            case .PI:
                print("PI")
            }

        }
        
    }

    
    init() {
        processTypes = ["FOWDT" : .FOWDT,
                        "SO" : .SO,
                        "SOWDT": .SOWDT,
                        "LFO" : .LFO,
                        "I" : .I,
                        "IFO" : .IFO,
                        "IFOWDT" : .IFOWDT ]
        
        controlModes = ["PI" : .PI,
                        "PID" : .PID]
        
        controllerTypes = ["Parallel" : .Parallel,
                           "Series" : .Series]
        }
}
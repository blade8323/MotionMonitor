//
//  ViewController.swift
//  MotionMonitor
//
//  Created by Владислав Соколов on 11.09.2020.
//  Copyright © 2020 Владислав Соколов. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet var gyroscopeLabel: UILabel!
    @IBOutlet var accelerometerLable: UILabel!
    @IBOutlet var attitudeLabel: UILabel!
    
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: queue) { (motion, error) in
                if let motion = motion {
                    let rotationRate = motion.rotationRate
                    let gravity = motion.gravity
                    let userAcc = motion.userAcceleration
                    let attitude = motion.attitude
                    let gyroscopeText = String(format: "Rotation Rate:\n------------------\nx: %+.2f\ny: %+.2f\nz: %+.2f\n", rotationRate.x, rotationRate.y, rotationRate.z)
                    let acceleratorText = String(format: "Acceleration:\n------------------\nGravity x: %+.2f\t\tUser x: %+.2f\nGravity y: %+.2f\t\tUser y: %+.2f\nGravity z: %+.2f\t\tUser z: %+.2f\n", gravity.x, userAcc.x, gravity.y, userAcc.y, gravity.z, userAcc.z)
                    let attitudeText = String(format: "Attitude: \n------------------\nRoll: %+.2f\nPitch: %+.2f\nYaw: %+.2f\n", attitude.roll, attitude.pitch, attitude.yaw)
                    
                    DispatchQueue.main.async {
                        self.gyroscopeLabel.text = gyroscopeText
                        self.accelerometerLable.text = acceleratorText
                        self.attitudeLabel.text = attitudeText
                    }
                }
            }
        }
    }


}


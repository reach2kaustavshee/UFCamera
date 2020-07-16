//
//  UFCameraViewController.swift
//  UFCamera
//
//  Created by Kaustav Shee on 16/07/20.
//  Copyright © 2020 Kaustav Shee. All rights reserved.
//

import UIKit

public class UFCameraViewController: UIViewController {
    
    public static let shared = UFCameraViewController(nibName: "UFCameraViewController", bundle: bundle)
    
    public override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @IBOutlet var btnShutter:UIButton! {
        didSet {
            self.btnShutter.addTarget(self, action: #selector(shutterButtonClicked(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet var cameraLayer:UFCameraLayerView!
    
    @IBOutlet var menuButton:UIButton! {
        didSet {
            self.menuButton.addTarget(self, action: #selector(menuButtonClicked(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet var viewMenuContainer:UIView!
    
    @IBOutlet var settingsButton:UIButton! {
        didSet {
            self.settingsButton.addTarget(self, action: #selector(settingsButtonClicked(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet var viewSettingsContainer:UFSettingsContainer!
    
    @IBOutlet var menuWidthConstraint:NSLayoutConstraint!
    @IBOutlet var settingsWidthContraint:NSLayoutConstraint!
    
    public var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.viewSettingsContainer.switchCamera = { [unowned self] in
            self.switchCamera()
        }
    }


    @objc private func shutterButtonClicked(_ btn:UIButton) {
        self.cameraLayer.captureImage {(image, error) in
            self.photoCaptureCompletionBlock?(image,error)
        }
    }
    
    @objc private func menuButtonClicked(_ btn:UIButton) {
        if self.menuWidthConstraint.constant == 0.0 {
            self.menuWidthConstraint.constant = 100.0
        }else{
            self.menuWidthConstraint.constant = 0.0
        }
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func settingsButtonClicked(_ btn:UIButton) {
        if self.settingsWidthContraint.constant == 0.0 {
            self.settingsWidthContraint.constant = 50.0
        }else{
            self.settingsWidthContraint.constant = 0.0
        }
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func switchCamera() {
        do {
            try self.cameraLayer.switchCamera()
        }catch let err {
            debugPrint(err.localizedDescription)
        }
    }

}

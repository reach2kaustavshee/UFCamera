//
//  UFCameraView.swift
//  UFCamera
//
//  Created by Kaustav Shee on 22/12/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import UIKit

class UFCameraView: UIView {
    
    var view:UIView!
    
    var menuButton:UIButton!
    var viewMenuContainer:UIView!
    
    var settingsButton:UIButton!
    var viewSettingsContainer:UIView!
    
    var menuWidthConstraint:NSLayoutConstraint!
    var settingsWidthContraint:NSLayoutConstraint!

    internal override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    internal convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func setup() {
        let bundle = Bundle(for: type(of: self))
        guard let cameraView = bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return }
        self.view = cameraView
        
        self.translatesAutoresizingMaskIntoConstraints = false
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        
        let consLeading = NSLayoutConstraint(item: cameraView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        consLeading.identifier = "identifier KS 1"
        let consTrailing = NSLayoutConstraint(item: cameraView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        consTrailing.identifier = "identifier KS 2"
        let consTop = NSLayoutConstraint(item: cameraView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        consTop.identifier = "identifier KS 3"
        let consBottom = NSLayoutConstraint(item: cameraView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        consBottom.identifier = "identifier KS 4"
        
        cameraView.frame = self.bounds
        self.addSubview(cameraView)
        
        self.addConstraints([consLeading,consTrailing,consTop,consBottom])
        
        loadAllSubviews()
    }
    
    private func loadAllSubviews() {
        if let vw = self.view.viewWithTag(101) {
            self.viewMenuContainer = vw
        }
        if let btn = self.view.viewWithTag(102) as? UIButton {
            self.menuButton = btn
            self.menuButton.addTarget(self, action: #selector(menuButtonClicked(_:)), for: .touchUpInside)
        }
        if let cons = self.viewMenuContainer.constraints.filter({ $0.identifier == "consMenuWidth" }).first {
            self.menuWidthConstraint = cons
        }
        if let vw = self.view.viewWithTag(103) {
            self.viewSettingsContainer = vw
        }
        //settingsButton
        if let btn = self.view.viewWithTag(104) as? UIButton {
            self.settingsButton = btn
            self.settingsButton.addTarget(self, action: #selector(settingsButtonClicked(_:)), for: .touchUpInside)
        }
        if let cons = self.viewSettingsContainer.constraints.filter({ $0.identifier == "consSettingsWidth" }).first {
            self.settingsWidthContraint = cons
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        self.menuWidthConstraint.constant = 0.0
        self.settingsWidthContraint.constant = 0.0
        super.willMove(toSuperview: newSuperview)
    }
    
    @objc private func menuButtonClicked(_ btn:UIButton) {
        if self.menuWidthConstraint.constant == 0.0 {
            self.menuWidthConstraint.constant = 70.0
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
    
    deinit {
        debugPrint("UFBannerView deinit")
    }
}

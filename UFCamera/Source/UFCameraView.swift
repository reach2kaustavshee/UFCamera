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
        
    }
    
    deinit {
        debugPrint("UFBannerView deinit")
    }
}

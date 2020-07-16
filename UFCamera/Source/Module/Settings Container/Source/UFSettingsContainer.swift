//
//  UFSettingsContainer.swift
//  UFCamera
//
//  Created by Kaustav Shee on 04/01/20.
//  Copyright © 2020 Kaustav Shee. All rights reserved.
//

import UIKit

class UFSettingsContainer: UIView {

    var view:UIView!
    var table:UITableView! {
        didSet {
            table.register(UINib(nibName: "UFSettingsContainerTableViewCell", bundle: bundle), forCellReuseIdentifier: "UFSettingsContainerTableViewCell")
            table.delegate = self
            table.dataSource = self
        }
    }
    var switchCamera:(()->())? = nil
    
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
        guard let settingsContainer = bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return }
        self.view = settingsContainer
        
        self.translatesAutoresizingMaskIntoConstraints = false
        settingsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let consLeading = NSLayoutConstraint(item: settingsContainer, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        consLeading.identifier = "identifier KS 1"
        let consTrailing = NSLayoutConstraint(item: settingsContainer, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        consTrailing.identifier = "identifier KS 2"
        let consTop = NSLayoutConstraint(item: settingsContainer, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        consTop.identifier = "identifier KS 3"
        let consBottom = NSLayoutConstraint(item: settingsContainer, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        consBottom.identifier = "identifier KS 4"
        
        settingsContainer.frame = self.bounds
        self.addSubview(settingsContainer)
        
        self.addConstraints([consLeading,consTrailing,consTop,consBottom])
        
        loadAllSubviews()
    }
    
    private func loadAllSubviews() {
        if let tbl = self.view.viewWithTag(101) as? UITableView {
            self.table = tbl
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.table.reloadData()
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
}

extension UFSettingsContainer {
    
    enum ToggleCameraState {
        case front
        case rear
        
        var image:UIImage? {
            return UIImage(named: "rotate_camera.png", in: bundle, compatibleWith: nil)
        }
    }
    
    enum FlashCameraState {
        case flashOn
        case flashOff
        case flashAdvance
        
        var image:UIImage? {
            switch self {
            case .flashOn:
                return UIImage(named: "with_flash.png", in: bundle, compatibleWith: nil)
            case .flashOff:
                return UIImage(named: "no_flash.png", in: bundle, compatibleWith: nil)
            case .flashAdvance:
                return UIImage(named: "flash_advance.png", in: bundle, compatibleWith: nil)
            }
        }
    }

    enum TableCellContent:String,CaseIterable {
        case ToggleCamera = "Toggle Camera"
        case FlashState = "Flash State"
    }
    
}

extension UFSettingsContainer:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UFSettingsContainer.TableCellContent.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UFSettingsContainerTableViewCell", for: indexPath) as! UFSettingsContainerTableViewCell
        
        if UFSettingsContainer.TableCellContent.allCases[indexPath.row] == .ToggleCamera {
            cell.imageDisplay.image = UFSettingsContainer.ToggleCameraState.front.image
        }
        else if UFSettingsContainer.TableCellContent.allCases[indexPath.row] == .FlashState {
            cell.imageDisplay.image = UFSettingsContainer.FlashCameraState.flashAdvance.image
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UFSettingsContainer.TableCellContent.allCases[indexPath.row] == .ToggleCamera {
            self.switchCamera?()
        }
        else if UFSettingsContainer.TableCellContent.allCases[indexPath.row] == .FlashState {
            
        }
    }
    
}






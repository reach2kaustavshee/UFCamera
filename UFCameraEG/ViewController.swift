//
//  ViewController.swift
//  UFCameraEG
//
//  Created by Kaustav Shee on 22/12/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import UIKit
import UFCamera
import Photos

class ViewController: UIViewController {
    
//    @IBOutlet var vwCamera:UFCameraView!
    
    @IBOutlet var tblDisplay:UITableView! {
        didSet{
            tblDisplay.tableFooterView = UIView()
        }
    }
    var allMode:[String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        allMode = loadAllModuleList()
        tblDisplay.reloadData()
    }
    
    
    private func loadAllModuleList() -> [String]? {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String]?
        let plistPath: String? = Bundle.main.path(forResource: "Mode", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String]
            print(plistData ?? "")
            return plistData
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            return nil
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allMode?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.allMode?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func openCamera(){
            self.present(UFCameraViewController.shared, animated: true, completion: nil)
        }
        func openPhotoGallery(){}
        func barcodeScanner(){}
        func qrCodeScanner(){}
        func pdfScanner(){}
        func videoRecording(){}
        func panorama(){}
        
        
        switch indexPath.row {
        case 0:
            openCamera()
        case 1:
            openPhotoGallery()
        case 2:
            barcodeScanner()
        case 3:
            qrCodeScanner()
        case 4:
            pdfScanner()
        case 5:
            videoRecording()
        case 6:
            panorama()
        default:
            break
        }
    }
    
}


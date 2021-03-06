//
//  CafeDetailsViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 5/7/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

class CafeDetailViewController: UITableViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    
    // MARK: - Actions
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
// MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = ""
        categoryLabel.text = ""
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        
        if let placemark = placemark {
            addressLabel.text = string(from: placemark)
        }
            
        else {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = format(date: Date())
    }
    
// MARK: - Helper Methods
    func string(from placemark: CLPlacemark) -> String {
        var line1 = ""
        
//        if let s = placemark.name {
//            line1 += s + " "
//        }
        
        if let s = placemark.subThoroughfare {
            line1 += s + ", "
        }
            
        if let s = placemark.thoroughfare {
            line1 += s + ", "
        }
            
        var line2 = ""
        
        if let s = placemark.locality {
            line2 += s + ", "
        }
        if let s = placemark.administrativeArea {
            line2 += s + " "
        }
            
        if let s = placemark.postalCode {
            line2 += s + ", "
        }

        return line1 + "\n" + line2
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
}

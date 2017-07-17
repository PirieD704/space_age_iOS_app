//
//  SpaceAgeVC.swift
//  Space Age
//
//  Created by Franks, Kent on 6/28/17.
//  Copyright © 2017 KefBytes. All rights reserved.
//

import UIKit

class SpaceAgeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var ageInputTextField: UITextField!
    @IBOutlet weak var planetPicker: UIPickerView!
    
    let planets = PlanetCollection()
    var selectedPlanet = Planet(name: "Earth", orbitalRatio: 1.0, demonym: "Earthling")
    
    let earthYearInSeconds: Float = 31557600.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.setTitleColor(UIColor .red, for: UIControlState .normal)
        print("Default planet is \(selectedPlanet.name)")
    }
    
    
    @IBAction func showCalculationAction(_ sender: Any) {
        print("🤖 printing something")
        if let age = ageInputTextField.text {
            if age != "" {
                let ageInSecs = ageToSeconds(ageInYears: Int(age)!)
                let planetAge = selectedPlanet.ageToPlanetYears(ageInEarthSeconds: ageInSecs)
                calculationLabel.text = "You are \(planetAge) in \(selectedPlanet.demonym) years!"
            } else {
                calculationLabel.text = "Please enter an Age!"
            }
        }
    }
    
    func ageToSeconds(ageInYears: Int) -> Float {
        return Float(ageInYears) * earthYearInSeconds
    }
    
    // MARK: - Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK: - Picker Delegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return planets.milkyWay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlanet = planets.milkyWay[row]
        ageInputTextField.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: planets.milkyWay[row].name,
                                  attributes: [NSFontAttributeName:UIFont(name: "Futura", size: 26.0)!,
                                               NSForegroundColorAttributeName:UIColor.white])
    }
    
    override func resignFirstResponder() -> Bool {
        print("resignFirstResponder")
        return true
    }
}

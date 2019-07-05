//
//  AddPostViewController.swift
//  CurrencySwap
//
//  Created by Admin on 2019-07-03.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import FirebaseDatabase
import FirebaseAuth

class AddPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate  {

    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var convertedValue: Double!
    var newPost: Post?
    
    let api = "84795df821cc93762ba5a09b372ae53c"
    
    let locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var completeLocationName: String?

     var ref: DatabaseReference!
    
    @IBOutlet weak var seacrhRadius: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var myMoneyTypeTF: UITextField!
    @IBOutlet weak var myMoneyAmountTF: UITextField!
    @IBOutlet weak var yourMoneyAmountTF: UITextField!
    @IBOutlet weak var yourMoneyTypeTF: UITextField!
    
//    var listOfCountry = ["CAD", "HKD","ISK","PHP", "DKK", "HUF", "CZK", "AUD", "RON", "SEK", "IDR", "INR", "BRL", "RUB", "HRK", "JPY", "THB", "CHF", "SGD", "PLN", "BGN", "TRY", "CNY", "NOK", "NZD", "ZAR", "USD", "MXN", "ILS", "GBP", "KRW", "MYR"]
    
    var listOfCountry = ["HKD", "CAD", "USD","ISK", "AUD", "RON", "SEK", "IDR", "INR", "GBP", "KRW", "MYR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.isHidden = false
        let myMoneyPickerView = UIPickerView()
        myMoneyPickerView.delegate = self
        myMoneyPickerView.tag = 1
        myMoneyTypeTF.inputView = myMoneyPickerView
        
        let yourMoneyPickerView = UIPickerView()
        yourMoneyPickerView.delegate = self
        yourMoneyPickerView.tag = 2
        yourMoneyTypeTF.inputView = yourMoneyPickerView
        
        self.hideKeyboardWhenTappedAround()
        getLocation()
    }
    
    @IBAction func addPost(_ sender: Any) {
        let identifier = UUID()
        print(identifier)
        let user = Auth.auth().currentUser!
        let allPostData = Database.database().reference(withPath: "allPost")
        let allPostData1 = allPostData.child(user.uid)
//        let allPostData = self.ref.child("allPost").child(user.uid)
        
        let postData = allPostData1.childByAutoId().child("post")
        postData.setValue(["Location": "\(locationTF.text ?? "")",
            "myAmount": "\(myMoneyAmountTF.text ?? "0.0")",
            "myCurrency": "\(myMoneyTypeTF.text ?? "")",
            "radius": "\(seacrhRadius.text ?? "0.0")",
            "yourAmount": "\(yourMoneyAmountTF.text ?? "0.0")",
            "yourCurrency": "\(yourMoneyTypeTF.text ?? "")"])
        
//        let postData = allPostData.child(user.uid)
//        postData.setValue("uniqueId": "\(identifier)")
        _ = navigationController?.popViewController(animated: true)
    }
    
  
    
    
    @IBAction func loadLoaction(_ sender: Any) {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                
                // Place details
                guard let placeMark = placemarks?.first else { return }
                
//                // Location name
//                if let locationName = placeMark.location {
//
//                    print(locationName)
//                }
//                // Street address
//                if let street = placeMark.thoroughfare {
//                    self.completeLocationName = "\(street)"
//                    print(street)
//                }
                // City
                if let city = placeMark.subAdministrativeArea {
                     self.locationTF.text = "\(city)"
                    print(city)
                }
        })
        
    }
    
    
    @IBAction func checkConversion(_ sender: Any) {
     
        let urlString = "http://data.fixer.io/api/convert?access_key=\(self.api)&from=\(myMoneyTypeTF.text ?? "CAD")&to=\(yourMoneyTypeTF.text ?? "USD")&amount=\(myMoneyAmountTF.text ?? "10")"
        getDataFromApi(url: urlString) { (response) in
            let finalResultInString:String = String(format:"%.1f", response.result ?? 0.0)
            self.yourMoneyAmountTF.text = finalResultInString
        }
    }

    typealias CompletionHandler = (_ data:Result) -> Void
    
    func getDataFromApi(url: String,completionHandler: @escaping CompletionHandler) {
        
        // download code.
        var result = Result()
        
        AF.request(url).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do{
                result = try JSONDecoder().decode(Result.self, from: data)
                
                completionHandler(result)
                
            }catch let jsonError{
                print(jsonError.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            
            return listOfCountry.count
            
        }
        
        if pickerView.tag == 2 {
            
            return listOfCountry.count
            
        }
        
        return listOfCountry.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
           
            return listOfCountry[row]
            
        }
        
        if pickerView.tag == 2 {
            
            return listOfCountry[row]
            
        }
        
        return nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            
            myMoneyTypeTF.text = listOfCountry[row]
        }
        
        if pickerView.tag == 2 {
            
            yourMoneyTypeTF.text = listOfCountry[row]
            
        }
    }
    
    
    func getLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
//            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userLocation = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    

   

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

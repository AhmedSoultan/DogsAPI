//
//  ViewController.swift
//  Dogs
//
//  Created by Ahmed Sultan on 8/25/19.
//  Copyright © 2019 Ahmed Sultan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    var breads = [String]()
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DogAPI.fetchListOfAllBread(completionHandler: self.handleFetchAllOfBread(breads:error:))
    }
    //MARK: - Custom functions
    func handleRequestRandomDogImage(imageData:String?, error:Error?) {
        guard let imageData = imageData else {
            print(error!)
            return
        }
        let dogImageURL = URL(string: imageData)!
        DogAPI.fetchRandomDogImage(url: dogImageURL, completionHandler: self.handleFetchDogImage(image:error:))
        
    }
    func handleFetchDogImage(image:UIImage?, error:Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    func handleFetchAllOfBread(breads: [String], error:Error?) {
        self.breads = breads
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
}
extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    //MARK: - Picker view data sourrce
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breads.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breads[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImageByBread(bread: breads[row], completionHandler: self.handleRequestRandomDogImage(imageData:error:))
    }
}


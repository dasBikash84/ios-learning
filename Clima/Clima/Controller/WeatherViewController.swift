import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchText: UITextField!
    
    var weatherManager : WeatherManager? = nil
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        weatherManager = WeatherManager(delegate: self)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func updateLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location!")
        for location in locations{
            print(location)
            geocode(location: location, completion: {
                (placemark:[CLPlacemark]?,error: Error?) in
                if placemark != nil{
                    for i in placemark!{
                        print(i.name)
                        print(i.postalCode)
                        print(i.country)
                        print(i.administrativeArea)
                        print(i.locality)
                    }
                }
                if error != nil{
                    print(error)
                }
            })
            self.weatherManager?.fetchWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func geocode(location:CLLocation, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        self
            .geoCoder
            .reverseGeocodeLocation(
                CLLocation(latitude: location.coordinate.latitude, longitude:  location.coordinate.longitude),
                completionHandler: completion
        )
    }
}

//MARK: - WeatherUpdateHandler

extension WeatherViewController: WeatherUpdateHandler {
    
    func didFailWithError(with error: Error) {
        print("From WeatherViewController : \(error)")
    }
    
    func didUpdateWeather(with weather: WeatherModel) {
        print("From WeatherViewController : \(weather)")
        runOnMainThread {
            self.temperatureLabel.text = weather.temperatueString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchTextEntered(_ sender: UITextField) {
        //        print("searchTextEntered")
        //        print(searchText.text!)
        weatherManager?.fetchWeather(cityName: searchText.text!)
        searchText.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        print("textFieldShouldReturn")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear")
        return true
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchText.endEditing(true)
        //        searchTextEntered(searchText)
    }
}

extension UIViewController{
    func runOnMainThread(task:@escaping ()->Void){
        DispatchQueue.main.async{task()}
    }
}

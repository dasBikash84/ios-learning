import Foundation

struct CoinManager {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let apiKey = "NTIyMDdlODFhNDZiNDM2YzkwMzFlYmNhODhkNTJhMTg"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate:TickerUpdateHandler?=nil
    
    func fetchRate(currencyIndex:Int){
        print(currencyArray[currencyIndex])
        let url = "\(baseURL)\(currencyArray[currencyIndex])"
        print("fetchRate: \(url)")
        performRequest(urlString: url)
    }
    
    func performRequest(urlString:String){
            
            if let url = URL(string: urlString){
                print("performRequest: \(url)")
                
                let session = URLSession(configuration: .default)
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                request.setValue(Constants.apiKey, forHTTPHeaderField: "x-ba-key")
                
                let task = session.dataTask(with: request) {
                    (data : Data?, response : URLResponse?, error : Error?) in
                    print("Callback called")
                    if error != nil {
                        print(error)
                        self.delegate?.didFailWithError(with: error!)
                        return
                    }
                    
//                    print(response)
                    
                    if let safeData = data {
                        if let tickerBtc = self.parseJson(safeData){
                            print(tickerBtc)
                            self.delegate?.didUpdateTicker(with: tickerBtc.tickerUpdateModel)
                        }
                    }

//                    print(String(data:data!,encoding: .utf8))
                    
                }
                
                task.resume()
                print("Task fired")
            }
        }
        
        func parseJson(_ data:Data) -> TickerBtc? {
            let decoder = JSONDecoder()
            do{
                let tickerBtc = try decoder.decode(TickerBtc.self, from: data)
                print("Decoded data: \(tickerBtc)")
                return tickerBtc
            }catch{
                print("Error during jason unmarshal")
                print(error)
                delegate?.didFailWithError(with: error)
                return nil
            }
        }

    
}

protocol TickerUpdateHandler {
    func didUpdateTicker(with tickerUpdateModel:TickerUpdateModel)
    func didFailWithError(with error:Error)
}

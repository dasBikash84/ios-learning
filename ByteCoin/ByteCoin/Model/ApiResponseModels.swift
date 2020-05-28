//
//  ApiResponseModels.swift
//  ByteCoin
//
//  Created by bikash on 28/5/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct TickerBtc:Decodable {
//    let ask:Double
//    let bid:Double
    let last:Double
//    let high:Double
//    let low:Double
//    let volume:Double
    
//    let open:OpenInfo
//    let averages:AverageInfo
    
//    let volume_percent:Double
//    let timestamp:Int
//    let display_timestamp:String
    let display_symbol:String
    
    var tickerUpdateModel:TickerUpdateModel {
        get{
            TickerUpdateModel(lastValue: String(format: "%.02f", last), curencySymbol: display_symbol.getAfter(from: "-"))
        }
    }
}

struct OpenInfo:Decodable {
    let hour:Double
    let day:Double
    let week:Double
    let month:Double
    let month_3:Double
    let month_6:Double
    let year:Double
}

struct AverageInfo:Decodable {
    let day:Double
    let week:Double
    let month:Double
}

struct TickerUpdateModel {
    let lastValue:String
    let curencySymbol:String
}

extension String{
    func getAfter(from str:Character) -> String{
        
        var startIndex:Index
        
        if let strIndex = self.firstIndex(of: str){
            startIndex = self.index(after:strIndex)
        }else{
            startIndex = self.startIndex
        }
        
        return String(self[startIndex..<self.endIndex])
    }
}

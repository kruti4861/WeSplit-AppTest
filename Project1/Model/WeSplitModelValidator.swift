//
//  WeSplitModelValidator.swift
//  Project1
//
//  Created by vn00082 on 10/14/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import Foundation

class WeSplitModelValidator{
    //MARK: function for validating Amount
    func isAmountValid(amount:Int)->Bool{
        var returnValue = true
        
        if (amount != nil && amount >= 1){
        return returnValue
        }
        return false

    }
    //MARK: Function for Validating Number of People
    func isNumValid(numbOfPeople:Int)->Bool {
        var returnValue = true
        if (numbOfPeople != nil) && (numbOfPeople <= 10 ) && (numbOfPeople > 1){
            return returnValue
        }
        return false
    }
    //Mark: Function for validating Tip Amount
    func isValidTip(value TipAmount: Int, in array: [Int]) -> Int?{
        if(TipAmount != nil){
        for(index,value) in array.enumerated(){
            if value == TipAmount{
                return TipAmount
            }
        }
    }
        return nil
    }
    //MARK: Function to validate the final per person amount
    func CalculateFinalAmount(Amount:Double, NbrofP:Double,tipAdd:Double)->Double{
        let tip = Double(Amount/100)
        let tipValue = Double(tip*tipAdd)
        let grandTotal = Double(Amount + tipValue)
        let amountPerPerson = Double(grandTotal / NbrofP)
        return amountPerPerson
    }
    
    
}

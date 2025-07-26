//
//  ContentView.swift
//  WeSplit
//
//  Created by Sougato Roy on 26/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfpeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    //let tipPercentages = [10, 15, 20, 25, 0]

    var total : Double {
        //convert the resulting value to a Double because it needs to be used alongside the checkAmount
        //this thing has the range 2 to 100, but it counts from 0, which is why we need to add the 2
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelection / 100)
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson : Double {
        //convert the resulting value to a Double because it needs to be used alongside the checkAmount
        let peopleCount = Double(numberOfpeople + 2)
        let totalPerPersonValue = total / peopleCount
        
        return totalPerPersonValue
    }
    
    var body: some View {
        
        //gives us some space across the top to place a title, and also lets iOS slide in new views as needed
        NavigationStack{
            Form{
                //Section 1 for the input and selection
                Section{
                    TextField("Amount ", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).focused($amountIsFocused)
                    //1st parameter is the placeholder text, 2nd one is the two-way binding to our property, 3rd is the way the text is formatted
                    
                    Picker("Number of people ", selection: $numberOfpeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    //moves the user to a new screen to select their option
                }
                
                //Section 2 for Tip Percentage
                Section("How much tip do you want to leave?"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                //Section 3 for showing the total amount i.e., bill amount + tip
                Section("Your total amount"){
                    
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                //Section 4 for displaying the Split Amount
                Section("There goes your split amount including \(tipPercentage)% tip"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    //Text("Number of people = \(numberOfpeople)")
                }
            }
            //Title to the Form
            //by attaching the title to the thing inside the navigation stack we’re allowing iOS to change titles freely
            .navigationTitle("WeSplit")
            //add a toolbar button when the text field is active
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        //when the button is pressed, it sets amountIsFocused to false so that the keyboard is dismissed
                        amountIsFocused = false
                    }
                }
            }
        }
        
        //.padding()
    }
}

#Preview {
    ContentView()
}

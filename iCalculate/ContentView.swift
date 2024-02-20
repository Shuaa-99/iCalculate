
//  ContentView.swift
//  Calculator App
//
//  Created by SHUAA on 09/03/1445 AH.
//

import SwiftUI

struct ContentView: View {
    let grid = [
        ["AC","DEL","%","/"],
        ["7","8","9","x"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        [".","0","","="] ]
    
    let operators = ["%","+","x","/"]
    
    @State var visibalWorking = ""
    @State var visibalResult = ""
    @State var showAlert = false
    
    var body: some View {
        NavigationView{
        VStack{
            HStack{
                Spacer()
                Text(visibalWorking)
                    .padding()
                    .foregroundColor(Color.purple)
                    .font(.system(size: 30,weight: .heavy))
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
            HStack{
                Spacer()
                Text(visibalResult)
                    .padding()
                    .foregroundColor(Color.green)
                    .font(.system(size: 30,weight: .heavy))
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
            ForEach(grid,id: \.self){
                row in
                HStack{
                    ForEach(row, id: \.self){
                        cell in
                        Button(action: {buttonPreass(cell : cell)},label:{
                            Text(cell)
                                .foregroundColor(buttonColor(cell))
                                .font(.system(size: 30,weight: .heavy))
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                        })
                    }
                }
                
            }
            
            .background(Color.purple.ignoresSafeArea())
            .alert(isPresented: $showAlert){
                Alert(title: Text(""),
                      message: Text(""),
                      dismissButton: .default(Text("OK")))
            }
            
        }
    }.navigationViewStyle(StackNavigationViewStyle())
    }
    func buttonColor (_ cell: String)-> Color{
        if (cell == "AC" || cell == "DEL"){return .gray}
        if (cell == "-" || cell == "-") || operators.contains(cell){return .green}
        return .white
    }
    func buttonPreass(cell: String){
        switch(cell){
        case "AC":
            visibalWorking = ""
            visibalResult = ""
        case "DEL":
            visibalWorking = String(visibalWorking.dropLast())
        case "=":
            visibalResult = calculatorResulte()
            
        case "-": addMinus()
            
        case ("%"),("+"),("x"),("/"): addOprator(cell)
            
        default: visibalWorking += cell
        }
    }
    func addOprator(_ cell: String){
        if !visibalWorking.isEmpty{
            let last = String(visibalWorking.last!)
            if operators.contains(last){
                visibalWorking.removeLast()
            }
            visibalWorking += cell
        }
    }
    func addMinus(){
        if visibalWorking.isEmpty || visibalWorking.last != "-"{
            visibalWorking += "-"
        }
    }
    func calculatorResulte() -> String {
        if viludInpot() {
            var workings = visibalWorking.replacingOccurrences(of: "%", with: "*0.01")
            workings = workings.replacingOccurrences(of: "x", with: "*") // Corrected line
            let expression = NSExpression(format: workings)
            let resulte = expression.expressionValue(with: nil, context: nil) as! Double
            return formatResulte(val: resulte)
        }
        showAlert = true
        return ""
    }  
    func viludInpot()->Bool{
        if (visibalWorking.isEmpty){
            return false
        }
        let last = String(visibalWorking.last!)
        if (operators.contains(last) || last == "-"){
            if (last != "%" || visibalWorking.count == 1){
                return false
            }
        }
        return true
    }
    
    func formatResulte(val :Double)-> String{
        if (val.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", val)
        }
        
        return String(format: "%.2f", val)
    }
}
    
    #Preview {
        ContentView()
           
    }


//
//  ContentView.swift
//  CCC_RandomWord
//
//  Created by kwon ji won on 2022/06/28.
//
import Foundation
import SwiftUI

struct ContentView: View {
    var Nums = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    @State private var selectNum = ""
    var body: some View {
        NavigationView{
            VStack{
                Picker("Choose a number", selection: $selectNum){
                    ForEach(Nums, id:\.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                .cornerRadius(15)
                .padding()
                Text("You selected: \(selectNum)")
                
                NavigationLink(destination : WordView(selectedNumber: $selectNum),
                               label: {Text("Show words!")})
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

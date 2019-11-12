//
//  ContentView.swift
//  AlamoSwiftui
//
//  Created by Victor Smirnov on 11.11.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var observed = Observer()
  
    var body: some View {
      NavigationView {
        List(observed.jokes) { i in
          HStack {Text(i.joke)
          }
        }.navigationBarItems(
          trailing: Button(action: addJoke, label: {
            Text("Add")
          }))
        .navigationBarTitle("SwuiftUI Alamofire")
      }
      
    }
  
  func addJoke() {
    observed.getJokes(count: 1)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

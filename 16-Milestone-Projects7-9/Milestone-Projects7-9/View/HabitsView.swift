//
//  ContentView.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject var habits = Habits()
    @State var showAddActivity = false

    var body: some View {
        NavigationView {
            List {
                ForEach(habits.activities) { activity in
                    VStack(alignment: .leading) {
                        Text(activity.title)
                            .font(.headline)
                        Text(activity.description)
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddActivity = true
                }) {
                    Image(systemName: "plus")
                        // increase tap area size
                        .frame(width: 44, height: 44)
                }
            )
        }
        .sheet(isPresented: $showAddActivity) {
            AddActivity(habits: self.habits)
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
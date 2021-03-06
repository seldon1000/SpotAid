//
//  SwiftUIView.swift
//  SpotAid
//
//  Created by SpaceAid Group on 09/11/21.
//

import SwiftUI
import EventKit

struct PlaceDetails: View {
    @StateObject var place: Place
    
    @State var isPresented: Bool = false
    @State var success: Bool = true
    @State var alerted: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(place.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height * 0.3)
                    .cornerRadius(16)
                    .shadow(radius: 8)
                HStack{
                    VStack{
                        VStack(alignment: .center) {
                            Text("\(Image(systemName: "star.fill")) \(place.rating)")
                                .font(.headline)
                            Text("Very good")
                                .font(.system(size: 12, weight: .regular))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("yellowDark"))
                        .background(.yellow.opacity(0.13))
                        .cornerRadius(12)
                        Text("Rating")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("yellowDark"))
                    }
                    .frame(width: (UIScreen.main.bounds.width - 48) / 3, height: UIScreen.main.bounds.height * 0.1)
                    Spacer()
                    VStack {
                        VStack(alignment: .center) {
                            Text("\(Image(systemName: "location.fill")) \(place.distance) km")
                                .font(.headline)
                            Text("From the Academy")
                                .font(.system(size: 12, weight: .regular))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("redDark"))
                        .background(.red.opacity(0.13))
                        .cornerRadius(12)
                        Text("Distance")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("redDark"))
                    }
                    .frame(width: (UIScreen.main.bounds.width - 48) / 3, height: UIScreen.main.bounds.height * 0.1)
                    Spacer()
                    VStack{
                        VStack {
                            Text("\(Image(systemName: "tram.fill")) \(place.transportLine)")
                                .font(.headline)
                            Text(place.transportStop)
                                .font(.system(size: 12, weight: .regular))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("greenDark"))
                        .background(.green.opacity(0.13))
                        .cornerRadius(12)
                        Text("Transport")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("greenDark"))
                    }
                    .frame(width: (UIScreen.main.bounds.width - 48) / 3, height: UIScreen.main.bounds.height * 0.1)
                }
                .frame(width: UIScreen.main.bounds.width - 32)
                .padding(.top, 12)
                .padding(.bottom, 8)
                Text("DESCRIPTION")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.leading, 16)
                    .padding(.bottom, 4)
                Text(place.description)
                    .padding()
                    .background(Color("myGray"))
                    .cornerRadius(16)
                Text("ADDRESS & MAP PREVIEW")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.leading, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                VStack(alignment: .leading) {
                    Text(place.address)
                        .padding()
                    Image(place.map)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.width - 32)
                        .cornerRadius(16)
                }
                .background(Color("myGray"))
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle(place.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isPresented.toggle() }) {
                    Image(systemName: "calendar.badge.plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: place.favorite) {
                    Image(systemName: place.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            if !success {
                alerted.toggle()
            }
        }) {
            NewEventSheet(isPresented: $isPresented, success: $success)
        }
        .alert(isPresented: $alerted) {
            Alert(
                title: Text("Cannot access the calendar"),
                message: Text("Try giving calendar permission to SpotAid inside the Settings app."),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
}

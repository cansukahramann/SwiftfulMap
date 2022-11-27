//
//  LocationsView.swift
//  SwiftfulMap
//
//  Created by Cansu Kahraman on 16.11.2022.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm : LocationsViewModel
    
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing:0){
                header
                    .padding()
                Spacer()
             locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation,onDismiss: nil ) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView{
    
    private var header: some View{
        VStack{
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + "/" + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay (alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 360 :270))
                    }
            }
            
            if vm.showLocationList{
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.5), radius:30, x:0,y:15)
    }
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7 )
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    private var locationsPreviewStack: some View{
        ZStack {
            ForEach(vm.locations){location in
                if vm.mapLocation == location{
                    LocationsPreviewView(location: location)
                        .shadow(color:.black.opacity(0.4),radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
            
        }
    }
}

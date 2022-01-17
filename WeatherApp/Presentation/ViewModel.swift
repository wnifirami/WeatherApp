//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import Foundation
import Combine
import Network
import CoreLocation
import SwiftUI

protocol PermissionProtocol: AnyObject {
    func request()
}

class ViewModel:NSObject, ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case success(WeatherRespense)
        case fail(Error)
        
        static func == (lhs: ViewModel.State, rhs: ViewModel.State) -> Bool {
            switch (lhs,rhs) {
            case (let .success(lhsdata), let .success(rhsdata)):
                return lhsdata.currently.time == rhsdata.currently.time
            case (let .fail(lhsfail), let .fail(rhsfail)):
                return lhsfail.localizedDescription == rhsfail.localizedDescription
            default:
                return false
            }
        }
    }
    @Published var networkStatus: NWPath.Status = .satisfied
    @Published private(set) var state = State.initial
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?

    var subscriptions = Set<AnyCancellable>()
    private let monitorQueue = DispatchQueue(label: "monitor")
    private let locationManager: CLLocationManager
    let service: WeatherServiceProtocol
    
    init(
        service: WeatherServiceProtocol,
        locationManager: CLLocationManager
    ) {
        self.service = service
        self.locationManager = locationManager
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        observeNetworkStatus()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.4
        locationManager.startUpdatingLocation()

    }
}

extension ViewModel {
    func getWeather() {
        self.state = .loading
        service.getWeatherInfo(
            coordinates: lastSeenLocation?.coordinate ?? CLLocationCoordinate2D(
                latitude: 36.806389,
                longitude: 10.181667
            )
        )
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.state = .fail(error)
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (response) in
                self.state = .success(response)
            }
            .store(in: &subscriptions)
    }
 
}

extension ViewModel: NetworkingProtocol {
    func observeNetworkStatus() {
       NWPathMonitor()
           .publisher(queue: monitorQueue)
           .receive(on: DispatchQueue.main)
           .sink { [weak self] status in
                self?.networkStatus = status
           }
           .store(in: &subscriptions)
   }
}

extension ViewModel: CLLocationManagerDelegate {
    func requestPermission() {
        switch authorizationStatus {
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestWhenInUseAuthorization()
        default:
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
}


extension ViewModel: PermissionProtocol {
    func request() {
        self.requestPermission()
    }
    
    
}

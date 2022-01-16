//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import Foundation
import Combine
import Network
class ViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case success(WeatherRespense)
        case fail(Error)
    }
    @Published var networkStatus: NWPath.Status = .satisfied
    @Published private(set) var state = State.initial

    var subscriptions = Set<AnyCancellable>()
    private let monitorQueue = DispatchQueue(label: "monitor")
    let service: WeatherServiceProtocol
    
    init(
        service: WeatherServiceProtocol
    ) {
        self.service = service
        observeNetworkStatus()
    }
}

extension ViewModel {
    func getWeather() {
        self.state = .loading
        service.getWeatherInfo()
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.state = .fail(error)
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (response) in
                debugPrint("response: \(response)")
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


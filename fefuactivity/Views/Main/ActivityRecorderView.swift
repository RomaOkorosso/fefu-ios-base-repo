//
//  ActivityRecorderView.swift
//  fefuactivity
//
//  Created by RomaOkorsso on 26.01.2022.
//

import SwiftUI
import MapKit
import Foundation

struct BottomSheetView<T: View>: View {
    @ViewBuilder var content: T

    var body: some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(24)
    }
}

enum ActivityType: String, CaseIterable {
    case bicycle = "Велосипед"
    case run = "Бег"
}

struct SelectActivityView: View {

    @State var selectedActivity = ActivityType.bicycle
    var onStart: (ActivityType) -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Погнали? :)")
                .font(.title2.bold())

            ScrollView(.horizontal) {
                HStack {
                    ForEach(ActivityType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .font(.title3.weight(.medium))
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: type == selectedActivity ? 4 : 0)
                            )
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedActivity = type
                            }
                    }
                }
            }

            Button {
                onStart(selectedActivity)
            } label: {
                Text("Старт")
                    .padding(.vertical, 16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
    }
}

struct ActivityRunningView: View {
    var delegate: ActivityRecorderDelegate?
    var startTime: Date
    var type: ActivityType

    @Environment(\.presentationMode) var presentationMode
    @Binding var distance: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(type.rawValue)
                .font(.title2.bold())

            HStack {
                Text("\(Int(distance))м")
                    .font(.title3)
                Spacer()
                Text(startTime, style: .timer)
                    .font(.title3)
            }

            HStack {
                Button("Pause") {}

                Spacer()

                Button("Save") {
                    
                }.simultaneousGesture(TapGesture().onEnded {
                    saveActivity()
                    presentationMode.wrappedValue.dismiss()
                })
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom)
    }

    private func saveActivity() {
        let timeFormatter = DateComponentsFormatter()
        let coreData = FEFUCoreDataContainer.instance
        let activity = CDActivity(context: coreData.context)

        timeFormatter.allowedUnits = [.hour, .minute, .second]
        timeFormatter.zeroFormattingBehavior = .pad

        activity.id = UUID()
        activity.duration = timeFormatter.string(from: startTime.timeIntervalSince(Date())) ?? ""
        activity.distance = getDistance(distance)
        activity.startDate = startTime
        activity.endDate = Date()
        activity.type = type.rawValue
        coreData.saveContext()

        delegate?.activityDidCreate()
    }

    private func getDistance(_ distance: Double) -> String {
        var formatted: Double = distance
        var postfix: String = "м"

        if distance > 1000 {
            formatted = distance / 1000
            postfix = "км"
        }

        return String(format: "%.2f", formatted) + postfix
    }
}

class DelegateShare: ObservableObject {
    @Published var delegate: ActivityRecorderDelegate?
}

struct ActivityRecorderView: View {
    var delegate: ActivityRecorderDelegate?

    @State var lineCoordinates: [CLLocation] = []
    @State var currentUserlocation = CLLocation()

    @State var activityStarted = false
    @State var selectedActivity: ActivityType = .bicycle

    @State var travaledDistance: CLLocationDistance = 0
    @State var startDate = Date()

    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(region: .init(.world),
                    lineCoordinates: lineCoordinates,
                    currentUserlocation: $currentUserlocation)
                .onChange(of: currentUserlocation) { newLocation in
                    guard activityStarted else { return }
                    if let last = lineCoordinates.last {
                        let distance = last.distance(from: newLocation)
                        travaledDistance += distance
                    }

                    lineCoordinates.append(newLocation)
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Новая активность")

            BottomSheetView {
                if !activityStarted {
                    SelectActivityView { type in
                        withAnimation {
                            selectedActivity = type
                            activityStarted = true
                            startDate = Date()
                        }
                    }
                } else {
                    ActivityRunningView(delegate: delegate, startTime: startDate, type: selectedActivity, distance: $travaledDistance)
                }
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct MapView: UIViewRepresentable {

    let region: MKCoordinateRegion
    let lineCoordinates: [CLLocation]

    @Binding var currentUserlocation: CLLocation

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.region = region

        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if let prevPolyline = view.overlays.compactMap({ $0 as? MKPolyline }).first {
            view.removeOverlay(prevPolyline)
        }

        let polyline = MKPolyline(coordinates: lineCoordinates.map(\.coordinate), count: lineCoordinates.count)
        view.addOverlay(polyline)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator($currentUserlocation)
    }
}

class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {

    @Binding var currentUserlocation: CLLocation

    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        return manager
    }()

    private let deviceLocationIdentifier = "locationAnnotation"

    weak var mapView: MKMapView?

    init(_ userLocation: Binding<CLLocation>) {
        _currentUserlocation = userLocation

        super.init()

        locationManager.delegate = self
        locationManager.distanceFilter = 1
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentUserlocation = location


    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor(named: "violet")
            renderer.lineWidth = 5
            return renderer
        }

        return MKOverlayRenderer()
    }

    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        self.mapView = mapView

        if let annotation = annotation as? MKUserLocation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: deviceLocationIdentifier)
            view.image = UIImage(named: "ActiveDeviceLocation")
            // Show icon in direction of movement
            if let course = annotation.location?.course {
                view.transform = .identity.rotated(by: self.deg2rad(course))
            }
            return view
        }

        return nil
    }
}

protocol ActivityRecorderDelegate {
    func activityDidCreate()
}

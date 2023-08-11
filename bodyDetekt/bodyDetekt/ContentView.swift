//
//  ContentView.swift
//  bodyDetekt
//
//  Created by Vitali Klopau on 07.08.2023.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.setupForBodyTracking()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

extension ARView: ARSessionDelegate {
    func setupForBodyTracking() {
        let config = ARBodyTrackingConfiguration()
        self.session.run(config)
        
        self.session.delegate = self
        
    }
    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let bodyAnchor = anchor as? ARBodyAnchor {
                print("Updatet bodyAncher")
                
                let skeleton = bodyAnchor.skeleton
                
                let rootJointTransform = skeleton.modelTransform(for: .root)!
                let rootJointPosition = simd_make_float3(rootJointTransform.columns.3)
                print("Root \(rootJointPosition)")
        
            }
        }
    }
}



struct ContentView: View {
    var body: some View{
        return ARViewContainer()
    }
}


    
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

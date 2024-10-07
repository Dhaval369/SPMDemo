//
//  SnapViewController.swift
//  
//
//  Created by Dhaval on 06/10/24.
//

import UIKit
import SCSDKCoreKit
import SCSDKCameraKit
import SCSDKCreativeKit

public class SnapViewController: UIViewController, SnapchatDelegate {

    let snapAPI = SCSDKSnapAPI()
    let snapAPIToken = "eyJhbGciOiJIUzI1NiIsImtpZCI6IkNhbnZhc1MyU0hNQUNQcm9kIiwidHlwIjoiSldUIn0.eyJhdWQiOiJjYW52YXMtY2FudmFzYXBpIiwiaXNzIjoiY2FudmFzLXMyc3Rva2VuIiwibmJmIjoxNzI2MDU1MDEzLCJzdWIiOiI1ZWQ4OTJjNi02MjczLTRjNTAtOGUyNy0xNDU0Nzg1NTM1OTB-U1RBR0lOR343YmUwZmY2MC0xMzU1LTRiMTEtYjgzYi0yNzNjMTYzZGYwMGIifQ.HppOSpcsG8rLY67SsiHDbOHBGzs09peFWpFLqBV1JDQ"
    let partnerGroupId = "f77f39ff-166a-4ad8-8eb9-c08cbbf9ad41"
    
    //@IBOutlet weak var tryOnButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showCameraControls(_ sender: Any) {
        startExperience()
    }
    
    func startExperience() {
        let cameraController = CameraController(sessionConfig: SessionConfig(apiToken: snapAPIToken))
        
        cameraController.groupIDs = [SCCameraKitLensRepositoryBundledGroup, partnerGroupId]
        cameraController.snapchatDelegate = self
        let cameraViewController = CameraViewController(cameraController: cameraController)
        
        self.present(cameraViewController, animated: true, completion: nil)

    }
    
    public func cameraKitViewController(_ viewController: UIViewController, openSnapchat screen: SnapchatScreen) {
        switch screen {
        case .profile, .lens(_):
            break
        case .photo(let image):
            let photo = SCSDKSnapPhoto(image: image)
            let content = SCSDKPhotoSnapContent(snapPhoto: photo)
            sendSnapContent(content, viewController: viewController)
        case .video(let url):
            let video = SCSDKSnapVideo(videoUrl: url)
            let content = SCSDKVideoSnapContent(snapVideo: video)
            sendSnapContent(content, viewController: viewController)
        }
    }

    private func sendSnapContent(_ content: SCSDKSnapContent, viewController: UIViewController) {
        viewController.view.isUserInteractionEnabled = false
        snapAPI.startSending(content) { error in
            DispatchQueue.main.async {
                viewController.view.isUserInteractionEnabled = true
            }
            if let error = error {
                print("Failed to send content to Snapchat with error: \(error.localizedDescription)")
                return
            }
        }
    }
}

//
//  QRCodeScannerView.swift
//

import UIKit
import AVFoundation
import CoreImage


open class QRCodeScannerView: UIView {
    
    // MARK: - Public
    /// layerClass
    open override class var layerClass: AnyClass { return AVCaptureVideoPreviewLayer.self }
    
    /// session
    public private(set) lazy var session = AVCaptureSession()
    
    /// scan frame
    public private(set) var scanFrame: CGRect = .null
    
    /// start scan
    ///
    /// - Parameters:
    ///   - frame: scan area
    ///   - callback: determine whether continue scan for current scanned string
    public func startScan(in frame: CGRect, callback: @escaping (String) -> () -> Bool) {
        guard self.isScanning == false else { return }
        self.isScanning = true
        
        _ = self.setUp
        
        self.scanFrame = frame
        self.callback = callback
        DispatchQueue.global().async {
            self.session.startRunning()
        }
    }
    
    /// stop scan
    public func stopScan() {
        guard self.isScanning == true else { return }
        self.isScanning = false
        self.session.stopRunning()
    }
    
    deinit {
        self.session.stopRunning()
    }
    
    // MARK: - Private
    /// is scanning
    private var isScanning: Bool = false
    
    /// callback
    private(set) var callback: ((String) -> () -> Bool)!
    
    /// set up
    private lazy var setUp: Void = {
        // input
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }
        self.session.addInput(input)
        
        // output
        let output = AVCaptureMetadataOutput()
        output.metadataObjectTypes = [.qr]
        output.setMetadataObjectsDelegate(self, queue: .main)
        self.session.addOutput(output)
        
        // previewLayer
        let previewLayer = self.layer as! AVCaptureVideoPreviewLayer
        previewLayer.videoGravity = .resizeAspectFill;
        previewLayer.session = self.session;
    }()
    
}

extension QRCodeScannerView {
    
    static var authorized: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) != .denied
    }
    
    static func requestAccessVideo(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
}

extension QRCodeScannerView: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects {
            if let codeObject = metadata as? AVMetadataMachineReadableCodeObject {
                if let obj = (self.layer as! AVCaptureVideoPreviewLayer).transformedMetadataObject(for: codeObject) as? AVMetadataMachineReadableCodeObject {
                    if self.scanFrame.contains(obj.bounds) {
                        if let str = codeObject.stringValue {
                            let isContinue = self.callback(str)()
                            if isContinue {
                                break
                            } else {
                                self.session.stopRunning()
                                return
                            }
                        }
                    }
                }
            }
        }
    }
}


extension QRCodeScannerView {
    
    /// gen QRCode
    static func genQR(string: String, size: CGSize) -> UIImage? {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else { return nil }
        guard let qrCodeFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrCodeFilter.setValue(data, forKey: "inputMessage")
        qrCodeFilter.setValue("L", forKey: "inputCorrectionLevel")
        guard var ciImg = qrCodeFilter.outputImage else { return nil }
        let scaleW = size.width / ciImg.extent.width
        let scaleH = size.height / ciImg.extent.height
        ciImg = ciImg.transformed(by: CGAffineTransform(scaleX: scaleW, y: scaleH))
        return UIImage(ciImage: ciImg)
    }
}


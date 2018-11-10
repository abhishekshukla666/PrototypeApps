//
//  ViewController.swift
//  ProgressBarCirclular
//
//  Created by Abhishek Shukla on 09/11/18.
//  Copyright © 2018 Abhishek Shukla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isDownloading: Bool = false
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    lazy var circularPath: UIBezierPath = {
        // Add Circular Path
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: (.pi * 2), clockwise: true)
        return circularPath
    }()
    
    lazy var trackLayer: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        
        // set center position
        trackLayer.position = view.center
        
        // Add Circular Path
        trackLayer.path = circularPath.cgPath
        
        // Set Stroke
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        
        // Rounded Cap
        trackLayer.lineCap = .round
        return trackLayer
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        
        // Add Position
        shapeLayer.position = view.center
        shapeLayer.transform = CATransform3DMakeRotation(-(.pi / 2), 0, 0, 1)
        
        // Add Circular Path
        shapeLayer.path = circularPath.cgPath
        
        // Set Stroke
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        
        // Rounded Cap
        shapeLayer.lineCap = .round
        return shapeLayer
    }()
    
    lazy var basicAnimation: CABasicAnimation = {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        return basicAnimation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    var downloadTask: URLSessionDownloadTask?
    private func initView() {
        
        shapeLayer.strokeEnd = 0
        view.addSubview(percentageLabel)
        //        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        guard let url = URL(string: urlString) else { return }
        downloadTask = urlSession.downloadTask(with: url)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
    }
    
    @objc private func handleTap() {
        //        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        downloadFile()
    }
    
    private func downloadFile() {
        
        if isDownloading {
            // Pause downloading
            downloadTask?.suspend()
            isDownloading = false
        } else {
            // Resume Downloading
            isDownloading = true
            downloadTask?.resume()
        }
    }
}

extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("\(totalBytesWritten)    \(totalBytesExpectedToWrite)")
        
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
        
    }
}


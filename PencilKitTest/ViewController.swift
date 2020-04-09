//
//  ViewController.swift
//  PencilKitTest
//
//  Created by Vijay Sharma on 2020-04-08.
//  Copyright © 2020 Vijay Sharma. All rights reserved.
//

import UIKit
import PencilKit

class ViewController: UIViewController {
	@IBOutlet weak var canvas: PKCanvasView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		canvas.backgroundColor = .lightGray
		canvas.allowsFingerDrawing = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
//		self.showPicker()
		self.perform(#selector(showPicker), with: self, afterDelay: 0)
	}
	
	@objc private func showPicker() {
		guard let window = UIApplication.shared.windows.filter({ $0.windowScene?.activationState == .foregroundActive }).first else {
			return
		}
		
		let picker = PKToolPicker.shared(for: window)
		if let picker = picker, picker.isVisible {
			return
		}
		
		print("Picker not visible")
		picker?.setVisible(true, forFirstResponder: canvas)
		picker?.addObserver(canvas)
		picker?.addObserver(self)
		
		canvas.becomeFirstResponder()
		
		self.perform(#selector(showPicker), with: self, afterDelay: 0.5)
	}
}


extension ViewController: PKToolPickerObserver {
	
}

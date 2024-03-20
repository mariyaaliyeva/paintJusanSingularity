//
//  CarrierState.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 19.03.2024.
//

import Foundation

class CarrierState {
	
	var states: [Memento] = []
	var canvas: Canvas
	var currentIndex: Int = 0
	
	init(canvas: Canvas) {
		self.canvas = canvas
	}
	
	func save() {
		let tail = (states.count) - 1 - currentIndex
		if tail > 0 { states.removeLast(tail) }
		
		states.append(canvas.save())
		currentIndex = (states.count) - 1
	}
	
	func undo(steps: Int) {
		guard steps <= currentIndex else { return }
		
		currentIndex -= steps
		canvas.restore(state: (states[currentIndex]))
	}
	
	func redo(steps: Int) {
		let newIndex = currentIndex + steps
		guard newIndex < states.count else { return }
		
		currentIndex = newIndex
		canvas.restore(state: states[currentIndex])
	}
}

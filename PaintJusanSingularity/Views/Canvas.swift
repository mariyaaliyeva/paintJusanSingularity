//
//  Canvas.swift
//  PaintJusanSingularity
//
//  Created by Mariya Aliyeva on 12.03.2024.
//

import UIKit

class Canvas: UIView {
	
	lazy var carrierState = CarrierState(canvas: self)
	
	private var shapes = [ShapeViewModel]()
	var color: UIColor = .black
	var shapeType: ShapeType = .pen
	var isFilled: Bool = false
	
	// Стандартный метод паттерна Memento
	func save() -> Memento {
		return StateShapesMemento(shapes: self.shapes)
	}
	
	// Стандартный метод паттерна Memento
	func restore(state: Memento) {
		self.shapes = state.shapesArray
		setNeedsDisplay()
	}
			
	override func draw(_ rect: CGRect) {
		
		shapes.forEach { shape in
			shape.points.forEach { fromPoint, toPoint in
				let factory = shape.type.factory
				let configuration = ShapeConfiguration (
					startPoint: fromPoint,
					endPoint: toPoint,
					isFilled: shape.isFilled,
					color: shape.color)
				
				let path = factory.create(configuration: configuration)
				path.stroke()
			}
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if shapes.isEmpty { carrierState.save() }
		guard let firstPoint = touches.first?.location(in: self) else { return }
		let viewModel = ShapeViewModel(
			points:[(fromPoint: firstPoint, toPoint: firstPoint)],
			color: color,
			isFilled: isFilled,
			type: shapeType)
		
		shapes.append(viewModel)
		setNeedsDisplay()
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard let currentPoint = touches.first?.location(in: self) else { return }
		
		guard var lastObject = shapes.popLast() else { return }
		guard var endPoint = lastObject.points.popLast() else { return }
		
		endPoint.toPoint = currentPoint
		lastObject.points.append(endPoint)
		
		if lastObject.type == .pen {
			lastObject.points.append((currentPoint, currentPoint))
		}
		shapes.append(lastObject)
		setNeedsDisplay()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		carrierState.save()
	}
	
	func undo() {
		carrierState.undo(steps: 1)
	}
	
	func redo() {
		carrierState.redo(steps: 1)
	}
}

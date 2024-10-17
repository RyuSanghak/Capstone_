//
//  Edge.swift
//  Capstone_
//
//  Created by Seokhyun Hong on 10/16/24.
//

public enum EdgeType {
    case directd, undirected
}

public struct Edge<T: Hashable> {
    public var source: Vertex<T> // 1
    public var destination: Vertex<T>
    public let weight: Double? // 2
}

extension Edge: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(destination)
        hasher.combine(weight)
    }
    
    static public func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool { // 2
        return lhs.source == rhs.source
        && lhs.destination == rhs.destination
        && lhs.weight == rhs.weight
    }
}

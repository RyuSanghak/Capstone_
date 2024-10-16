//
//  vertex.swift
//  Capstone_
//
//  Created by Seokhyun Hong on 10/16/24.
//

public struct Vertex<T: Hashable> {
    var data: T
}

extension Vertex: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }
    
    static public func ==(lhs: Vertex, rhs: Vertex) -> Bool { // 2
        return lhs.data == rhs.data
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}

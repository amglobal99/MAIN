//
//  Routing.swift
//  CorduxPrototype
//
//  Created by Ian Terrell on 7/22/16.
//  Copyright © 2016 WillowTree. All rights reserved.
//

import Foundation

//MARK:- ********* Route Struct *********

public struct Route  {
    var components: [String]
}

//MARK:-

public protocol RouteConvertible {
    func route() -> Route
}

//MARK:-

public enum RouteAction<T: RouteConvertible>: Action {
    case goto(T)
    case push(T)
    case pop(T)
    case replace(T, T)
}

//MARK:-

extension Route: RandomAccessCollection, Sequence, RangeReplaceableCollection, ExpressibleByArrayLiteral {}

//MARK:- Reducer

extension Store {
    
    func reduce<T>(_ action: RouteAction<T>, route: Route) -> Route {
        switch action {
        case .goto(let route):
            return route.route()
        case .push(let segment):
            return route + segment.route()
        case .pop(let segment):
            let segmentRoute = segment.route()
            let n = route.count
            let m = segmentRoute.count
            guard n >= m else {
                return route
            }
            let tail = Route(Array(route[n-m..<n]))
            guard tail == segmentRoute else {
                return route
            }
            return Route(route.dropLast(m))
        case .replace(let old, let new):
            let head = reduce(.pop(old), route: route)
            return reduce(.push(new), route: head)
        }
    }
    
}//end extension

//MARK:- Initializers

extension Route {
    public init() {
        self.components = []
    }

    public init(_ components: [String]) {
        self.components = components
    }

    public init(_ component: String) {
        self.init([component])
    }

    public init(_ slice: Slice<Route>) {
        self.init(Array(slice))
    }
}

//MARK:- Equatable

extension Route: Equatable {}

public func ==(lhs: Route, rhs: Route) -> Bool {
    return lhs.components == rhs.components
}


extension Route: RouteConvertible {
    public func route() -> Route {
        return self
    }
}

//MARK:- ExpressibleByArrayLiteral

extension Route {
    public init(arrayLiteral elements: String...) {
        components = elements
    }
}

//MARK:-

extension Route {
    
    public typealias Iterator = AnyIterator<String>
    
    public func makeIterator() -> Iterator {
        return AnyIterator(makeGenerator())
    }

    func makeGenerator() -> () -> (String?) {
        var index = 0
        return {
            if index < self.components.count {
                let c = self.components[index]
                index += 1
                return c
                
            }
            return nil
        }
    }
}

//MARK:-

extension Route {
    public typealias Index = Int

    public typealias Indices = CountableRange<Index>
    
    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return components.count
    }

    public func index(after i: Int) -> Int {
        return i + 1
    }

    public func index(before i: Int) -> Int {
        return i - 1
    }

    public subscript(i: Int) -> String {
        return components[i]
    }
}

extension Route {
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        components.reserveCapacity(minimumCapacity)
    }

    public mutating func replaceSubrange<C : Collection>(_ subRange: Range<Int>, with newElements: C) where C.Iterator.Element == Iterator.Element {
        components.replaceSubrange(subRange, with: newElements)
    }
   
}

public func +(lhs: Route, rhs: Route) -> Route {
    return Route(lhs.components + rhs.components)
}

public func +(lhs: RouteConvertible, rhs: Route) -> Route {
    return Route(lhs.route().components + rhs.components)
}

public func +(lhs: Route, rhs: RouteConvertible) -> Route {
    return Route(lhs.components + rhs.route().components)
}

//MARK:- RouteConvertible

extension String: RouteConvertible {
    
    public func route() -> Route {
        return Route(self)
    }
    
}

//MARK:- RawRepresentable

public extension RawRepresentable where RawValue == String {
    
    func route() -> Route {
        return self.rawValue.route()
    }
    
}

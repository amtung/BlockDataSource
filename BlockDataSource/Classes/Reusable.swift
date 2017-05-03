//
//  DataSourceReusable.swift
//  Pods
//
//  Created by Adam Cumiskey on 5/2/17.
//
//

import Foundation


// MARK: - DataSourceReusableProtocol
/// Any data type that can configure a view
public protocol ReusableProtocol {
    var configure: ConfigureBlock { get }
    var viewClass: UIView.Type { get }
    var reuseIdentifier: String { get }
}

public class ReusableBase {
    public var configure: ConfigureBlock
    public var viewClass: UIView.Type

    public var customReuseIdentifier: String?
    public var reuseIdentifier: String {
        if let customReuseIdentifier = customReuseIdentifier {
            return customReuseIdentifier
        } else {
            return String(describing: viewClass)
        }
    }

    init<View: UIView>(customReuseIdentifier: String? = nil, configure: @escaping (View) -> Void) {
        self.configure = { view in
            configure(view as! View)
        }
        self.viewClass = View.self
    }
}


public class Reusable: ReusableBase, ReusableProtocol {
    public override init<View: UIView>(customReuseIdentifier: String?, configure: @escaping (View) -> Void) {
        super.init(customReuseIdentifier: customReuseIdentifier, configure: configure)
    }
}

/// UIView for UITableView headers/footers
public class ListSectionDecoration: Reusable { }


/// UICollectionReusableView
public class GridSectionDecoration: Reusable {
    public override init<View: UICollectionReusableView>(customReuseIdentifier: String? = nil, configure: @escaping (View) -> Void) {
        super.init(customReuseIdentifier: customReuseIdentifier, configure: configure)
    }
}
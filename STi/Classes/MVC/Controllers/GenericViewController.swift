//
//  GenericViewController.swift
//


open class GenericViewController<ContentView: UIView>: ViewController {
    
    /// contentView
    public var contentView: ContentView!
    
    /// loadView
    open override func loadView() {
        self.view = UIView()
        self.contentView = ContentView(frame: self.view.bounds)
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(contentView)
    }
}

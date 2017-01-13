//
//  KWVerificationCodeView.swift
//  Pods
//
//  Created by KeepWorks on 11/01/17.
//  Copyright © 2017 KeepWorks Technologies Pvt Ltd. All rights reserved.
//

import UIKit

//public protocol KWVerificationCodeDelegate: class {
//  func getVerificationCode() -> String
//  func validateCode() -> Bool
//}

@IBDesignable open class KWVerificationCodeView: UIView {
  
  // MARK: - Constants
  static let maxCharactersLength = 1
  
  // MARK: - IBInspectables
  //@IBInspectable open var underlineColor: UIColor = UIColor.darkGray {
  //  didSet {
  //    underlineView.backgroundColor = self.underlineColor.withAlphaComponent(0.3)
  //  }
  //}
  
  // MARK: - IBOutlets
  @IBOutlet weak var textFieldView1: KWTextFieldView!
  @IBOutlet weak var textFieldView2: KWTextFieldView!
  @IBOutlet weak var textFieldView3: KWTextFieldView!
  @IBOutlet weak var textFieldView4: KWTextFieldView!
  
  // MARK: - Variables
  var mobile: String!
  var selectedVerificationCodeViewIndex = 0
  
  lazy var textFieldViews: [KWTextFieldView] = {
    [unowned self] in
    
    return [self.textFieldView1, self.textFieldView2, self.textFieldView3, self.textFieldView4]
    }()

  //weak public var delegate: KWVerificationCodeDelegate?
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    loadViewFromNib()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    loadViewFromNib()
    setupVerificationCodeViews()
    //numberTextField.delegate = self
    //NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: numberTextField)
  }
  
  deinit {
    //NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Public Methods
  public func getVerificationCode() -> String {
    var verificationCode = ""
    for textFieldView in textFieldViews {
      verificationCode += textFieldView.numberTextField.text!
    }
    
    return verificationCode
  }
  
  public func validateCode() -> Bool {
    for textFieldView in textFieldViews {
      if Int(textFieldView.numberTextField.text!) == nil {
        return false
      }
    }
    
    return true
  }

  // MARK: - Private Methods
  private func setupVerificationCodeViews() {
    for textFieldView in textFieldViews {
      textFieldView.delegate = self
    }
    
    textFieldViews.first?.activate()
  }
}

// MARK: - KWTextFieldDelegate
extension KWVerificationCodeView: KWTextFieldDelegate {
  func moveToNext(_ textFieldView: KWTextFieldView) {
    let validIndex = textFieldViews.index(of: textFieldView) == textFieldViews.count - 1 ? textFieldViews.index(of: textFieldView)! : textFieldViews.index(of: textFieldView)! + 1
    textFieldViews[validIndex].activate()
  }
  
  func moveToPrevious(_ textFieldView: KWTextFieldView, oldCode: String) {
    if textFieldViews.last == textFieldView && oldCode != " " {
      return
    }
    
    let validIndex = textFieldViews.index(of: textFieldView)! == 0 ? 0 : textFieldViews.index(of: textFieldView)! - 1
    textFieldViews[validIndex].activate()
    textFieldViews[validIndex].reset()
  }
}

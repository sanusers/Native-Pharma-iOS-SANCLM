//
//  SessionInfoTVC.swift
//  E-Detailing
//
//  Created by San eforce on 10/11/23.
//

import UIKit
//import 

extension SessionInfoTVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Remarks"
            textView.textColor = UIColor.lightGray
        }
        self.remarks = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.remarks = textView.text
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Remarks"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
      
        return false
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.contentView.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
class SessionInfoTVC: UITableViewCell {
    
    
    @IBOutlet var remarksHolderView: UIView!
    @IBOutlet var remarksHeight: NSLayoutConstraint!
    
    @IBOutlet var remarksTFholder: UIView!
    
    @IBOutlet var remarksTV: UITextView!
    @IBOutlet var stackHeight: NSLayoutConstraint!
    
    @IBOutlet var overallContentsHolder: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    
    ///Worktype outlets
    
    @IBOutlet weak var workTypeView: UIView!
    
    @IBOutlet weak var workselectionHolder: UIView!
    
    @IBOutlet var lblWorkType: UILabel!
    
    ///cluster type outlets
    
    @IBOutlet weak var clusterView: UIView!
    
  
    
    @IBOutlet weak var clusterselectionHolder: UIView!
    
    
    @IBOutlet var lblCluster: UILabel!
    
    ///headQuaters type outlets

    @IBOutlet var headQuatersView: UIView!
    
    @IBOutlet var headQuatersSelectionHolder: UIView!
    
    @IBOutlet var lblHeadquaters: UILabel!
    
    
    ///jointCall type outlets
    
    @IBOutlet var jointCallView: UIView!
    
    @IBOutlet var jointCallSelectionHolder: UIView!
    
    
    @IBOutlet var lblJointCall: UILabel!
    
    ///listedDoctor type outlets
    
    @IBOutlet var listedDoctorView: UIView!
    
    @IBOutlet var listedDoctorSelctionHolder: UIView!
    
    @IBOutlet var lblListedDoctor: UILabel!
    
    
    ///chemist type outlets
    
    @IBOutlet var chemistView: UIView!
    
    @IBOutlet var chemistSelectionHolder: UIView!
    
    @IBOutlet var lblChemist: UILabel!
    
    
    var remarks: String?
    var keybordenabled = Bool()
    var selectedIndex: Int = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        //remarksTV.placeholder = "Remarks"
        [chemistSelectionHolder,listedDoctorSelctionHolder,jointCallSelectionHolder,headQuatersSelectionHolder, clusterselectionHolder, workselectionHolder, overallContentsHolder, remarksTFholder].forEach { view in
            view?.layer.borderColor = Themes.appTextColor.cgColor //AppColors.primaryColorWith_40per_alpha.cgColor
            view?.layer.borderWidth = view == overallContentsHolder ? 0 : 1.5
            view?.layer.cornerRadius = 5
            view?.elevate(1)
        }
        configureTextField()
        initNotifications()
        
        
    }
    
    override func prepareForReuse() {
       /// deinit {
            NotificationCenter.default.removeObserver(self)
       /// }
    }
    
    func initNotifications() {
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
         
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
  
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if(keybordenabled == false){
        adjustInsetForKeyboardShow(show: true, notification: notification)
              keybordenabled = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
         keybordenabled = false

        adjustInsetForKeyboardShow(show: false, notification: notification)
    }
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if show {
                if self.frame.origin.y == 0 {
                    self.frame.origin.y -= keyboardSize.height
                    //+ CGFloat((selectedIndex * 620))
                }
            } else {
                if self.frame.origin.y != 0 {
                          self.frame.origin.y = 0
                      }
            }
            //  contentView.bottom += adjustment
            //  contentView.scrollIndicatorInsets.bottom += adjustment
            self.contentView.layoutIfNeeded()
        }
    }
    
    func configureTextField() {
        remarksTV.delegate = self
        remarksTV.text = "Remarks"
        remarksTV.textColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

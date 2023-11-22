import FSCalendar

class CustomCalendarCell: FSCalendarCell {

    // Your custom label
    var customLabel: UILabel!
    var contentHolderView : UIView = {
        let holder = UIView()
        holder.clipsToBounds = true
        holder.backgroundColor = .clear
      //  holder.layer.borderColor = UIColor.gray.cgColor
     //   holder.layer.borderWidth = 0.5
        return holder
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        // Initialize and configure your custom label
        customLabel = UILabel()
        customLabel.textAlignment = .right
        addSubview(contentHolderView)
        contentHolderView.addSubview(customLabel)
      //  addSubview(customLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Adjust the position of the custom label
        contentHolderView.frame = contentView.bounds
        customLabel.frame = CGRect(x: contentHolderView.width - contentHolderView.height / 3 - 10, y: 10, width: contentHolderView.height / 3, height: contentHolderView.height / 3)
       
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Reset the state of the custom cell
        customLabel.text = nil
       // contentHolderView.backgroundColor = .clear
    }
}

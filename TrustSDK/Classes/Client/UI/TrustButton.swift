// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit

public final class TrustButton: UIButton {
    private var isFullRounded: Bool = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        self.apply(theme: .blue)
    }

    public func apply(theme: TrustButtonTheme) {
        for style in theme.styles {
            apply(style: style)
        }
    }

    func apply(style: TrustButtonStyle) {
        switch style {
        case let .font(font):
            self.titleLabel?.font = font
        case let .title(style):
            guard let font = self.titleLabel?.font else {
                return
            }
            self.setAttributedTitle(style.title(font: font), for: .normal)
        case let .icon(icon, insets):
            self.setImage(icon.image, for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
            self.imageEdgeInsets = insets
        case let .tintColor(color):
            self.tintColor = color
        case let .backgroundColor(color):
            self.backgroundColor = color
        case let .border(width, color):
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
        case let .round(radius):
            self.layer.cornerRadius = radius
            self.isFullRounded = false
        case .roundFull:
            self.layer.cornerRadius = 0
            self.isFullRounded = true
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if isFullRounded {
            self.layer.cornerRadius = self.bounds.height / 2.0
        }
    }
}

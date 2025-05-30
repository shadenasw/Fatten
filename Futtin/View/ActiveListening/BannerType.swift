//
//  BannerType.swift
//  Futtin
//
//  Created by Lana Alyahya on 21/05/2025.
//


import SwiftUI

enum BannerType {
    case success, fail, timeout

    var iconName: String {
        switch self {
        case .success: return "checkmark"
        case .fail: return "xmark"
        case .timeout: return "clock"
        }
    }

    var title: String {
        switch self {
        case .success: return "أحسنت !"
        case .fail: return "تسرّعت !"
        case .timeout: return "فاتتك الفرصة!"
        }
    }

    var subtitle: String {
        switch self {
        case .success: return "قاطعت في اللحظة المناسبة"
        case .fail: return "قاطعت في الوقت الخاطئ"
        case .timeout: return "لم تقاطع أبدًا، رغم وجود لحظة مناسبة"
        }
    }



    var soundName: String {
        switch self {
        case .success: return "success_ping"
        case .fail: return "fail_ping"
        case .timeout: return "timeout_ping"
        }
    }
    var circleColor: Color {
        switch self {
        case .success:
            return Color("SuccessGreen")
        case .fail:
            return Color("reddd")
        case .timeout:
            return Color("yelloww")
        }
    }

}

//
//  HomeViewController.swift
//  flutter_plugin_scan
//
//  Created by sdaduanbilei on 2020/12/2.
//

import UIKit

class HomeViewController: UIViewController, HRQRCodeScanToolDelegate {
    func scanQRCodeFaild(error: HRQRCodeTooError) {
        switch error {
                    
                case .SimulatorError:
                    
                    print("请使用真机")
                    let action = UIAlertAction(title: "好的，我知道了", style: .default, handler: {(_ action: UIAlertAction) in
                    })
                    let alertVC = UIAlertController(title: "错误" , message: "请使用真机调试", preferredStyle: .alert)
                    alertVC.addAction(action)
                    self.present(alertVC, animated: true, completion: nil)
                    
                case .CamaraAuthorityError:
                    
                    let action = UIAlertAction(title: "确定", style: .default, handler: {(_ action: UIAlertAction) in
                        
                        let url = URL(string: UIApplication.openSettingsURLString)
                        UIApplication.shared.openURL(url!)
                    })
                    
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {(_ action: UIAlertAction) in
                        
                    })
                    let alertVC = UIAlertController(title: "提示", message: "请在设置中打开摄像头权限", preferredStyle: .alert)
                    alertVC.addAction(action)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                    
                case .OtherError:
                    print("其他错误")
                    
                    
                }
    }
    
    func scanQRCodeSuccess(resultStrs: [String]) {
        print("扫码成功 + \(resultStrs.first ?? "")")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 扫描
//        setupScanConfig()
        // 关闭按钮
        let scanBtn = UIButton(type: UIButton.ButtonType.system)
        let scanBtnSize = scanBtn.intrinsicContentSize.width * 0.8
        scanBtn.frame = CGRect(x: 20, y: 80,width: scanBtnSize ,height: scanBtnSize)
        scanBtn.setTitle("✕", for: UIControl.State.normal)
        scanBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        scanBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        scanBtn.backgroundColor = UIColor.white
        scanBtn.layer.cornerRadius = scanBtnSize / 2
        scanBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(scanBtn)
        // title
        let title = UILabel()
        title.text = "扫一扫"
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 18)
        title.textColor = UIColor.white
        let titleSize = title.intrinsicContentSize
        title.frame = CGRect(x: UIScreen.main.bounds.width / 2 -  titleSize.width / 2, y: 80 + 6  , width: titleSize.width, height: titleSize.height)
        view.addSubview(title)
        // 扫码线条
        let path = UIBezierPath()
        let startPoint = CGPoint(x: 10, y: 256)
        path.move(to: startPoint)
        path.lineWidth = 4
        path.addLine(to: CGPoint(x: 758, y: 256))
        path.close()
        
        let line = CAShapeLayer()
        line.path = path.cgPath;
        line.strokeColor = UIColor.green.cgColor
        line.fillColor = UIColor.red.cgColor
        
        view.layer.addSublayer(line)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = [0, 0]
        animation.toValue = [0, 300]
        animation.fillMode = .forwards
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = true
        animation.duration = 3
        line.add(animation, forKey: "myanimation")
    
        
        
        // 提示信息
        let tips = UILabel()
        tips.text = "扫二维码 / 条码"
        tips.adjustsFontSizeToFitWidth = true
        tips.font = UIFont.systemFont(ofSize: 12)
        tips.textColor = UIColor.white
        let lableSize = tips.intrinsicContentSize
        tips.frame = CGRect(x: UIScreen.main.bounds.width / 2 -  lableSize.width / 2, y: UIScreen.main.bounds.height  * 0.75, width: lableSize.width, height: lableSize.height)
        view.addSubview(tips)
        
        
        
        
    }
    
    
    @objc dynamic func  close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupScanConfig() {

           #if TARGET_IPHONE_SIMULATOR
           print("请用真机调试")
           return
           #endif
           
           let width: CGFloat                          = 300
           HRQRCodeScanTool.shared.isDrawQRCodeRect    = false
           HRQRCodeScanTool.shared.drawRectColor       = UIColor.green
           HRQRCodeScanTool.shared.drawRectLineWith    = 3
           HRQRCodeScanTool.shared.setInterestRect(originRect: CGRect(x:(view.frame.size.width - width) * 0.5, y: (view.frame.size.height - width) * 0.5, width: width, height: width))
           HRQRCodeScanTool.shared.delegate            = self
           HRQRCodeScanTool.shared.centerHeight        = 250
           HRQRCodeScanTool.shared.centerWidth         = 250
           HRQRCodeScanTool.shared.isShowMask          = false
           HRQRCodeScanTool.shared.maskColor           = UIColor.init(white: 0, alpha: 0.3)
           HRQRCodeScanTool.shared.beginScanInView(view: view)
       }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            HRQRCodeScanTool.shared.stopScan()
        }
}



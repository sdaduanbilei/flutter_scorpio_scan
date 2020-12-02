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
//        view.backgroundColor = UIColor.white
//        let title = UILabel()
//        title.text = "测试"
//        title.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
//        view.addSubview(title)
//        let scanBtn = UIButton(type: UIButton.ButtonType.infoDark)
//        scanBtn.setTitle("button", for: UIControl.State.normal)
//        scanBtn.frame = CGRect(x: 0, y: 200,width: 150 ,height: 100)
//        scanBtn.backgroundColor = UIColor.green
//        view.addSubview(scanBtn)
        
        setupScanConfig()
        
    }
    
    func setupScanConfig() {

           #if TARGET_IPHONE_SIMULATOR
           print("请用真机调试")
           return
           #endif
           
           let width: CGFloat                          = 300
           HRQRCodeScanTool.shared.isDrawQRCodeRect    = true
           HRQRCodeScanTool.shared.drawRectColor       = UIColor.purple
           HRQRCodeScanTool.shared.drawRectLineWith    = 1
           HRQRCodeScanTool.shared.setInterestRect(originRect: CGRect(x:(view.frame.size.width - width) * 0.5, y: (view.frame.size.height - width) * 0.5, width: width, height: width))
           HRQRCodeScanTool.shared.delegate            = self
           HRQRCodeScanTool.shared.centerHeight        = 200
           HRQRCodeScanTool.shared.centerWidth         = 200
           HRQRCodeScanTool.shared.isShowMask          = true
           HRQRCodeScanTool.shared.maskColor           = UIColor.init(white: 0, alpha: 0.2)
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



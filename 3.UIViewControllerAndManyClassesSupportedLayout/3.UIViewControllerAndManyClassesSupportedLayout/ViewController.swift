//
//  ViewController.swift
//  3.UIViewControllerAndManyClassesSupportedLayout
//
//  Created by 白数叡司 on 2021/06/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Notes
    /*
     3.1 レイアウトの構造とプロセス
     3.1.1 表示に関わる階層構造 - スクリーン、ウィンドウ、ビューコントローラ
     ・iOS、Macアプリは、最下層から順に
        「スクリーン、アプリを表示するウィンドウ、ウィンドウに付随するビューコントローラ、ビューコントローラが持つビュー」
     というようになっている
     [階層構造に登場するオブジェクト]
     * UIScreenオブジェクト：スクリーン
     * UIWindowオブジェクト：ウィンドウ
     * UIViewControllerのサブクラス：ビューコントローラ
     
     3.1.2 アプリの起動から表示までのプロセス
     [ビュー表示のためのレイヤー形成の流れ]
     ⅰ. 画面サイズに合わせたウィンドウの生成
     ⅱ. 生成したウィンドウをキーウィンドウとして指定(キーウィンドウ = キーボードなどのイベントを受け取ることができるウィンドウ)
     ⅲ. 表示したいビューコントローラをそのウィンドウのルートビューコントローラとして設定
     
     [開発者視点での最初のビューの設定方法]------------------------------------------------------
     (Storyboardを用いる時...)
     -> projectファイルの対象ターゲット内の設定内にある「Deployment Info」の「Main Interface」で起動時のStoryboardを設定する
     
     (Storyboardを用いない場合(コードベースで行う時)...)
     -> UIApplicationDelegateProtocolに従ってクラス(AppDelegate.swiftなど)において、アプリの起動を受け取るデリゲートメソッドであるapplication:didFinishLaunchingWithOptions:内で、
     1. ウィンドウを生成
     2. ウィンドウのrootViewControllerプロパティにビューコントローラを代入
     3. makeKeyWindow()をウィンドウをキーウィンドウにする
     ことでルートビューコントローラとして設定する
     
     func application(application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
         // 画面サイズに合わせてウィンドウを生成
         var window = UIWindow(frame: UIScreen.mainScreen().bounds)
         // ビューコントローラの生成
         let viewController = UIViewController()
         
         // ビューコントローラをルートビューコントローラに設定
         window.rootViewController = viewController
         // 対象のウィンドウをキーウィンドウにする
         window.makeKeyWindow()
         return true
     }
     -------------------------------------------------------------------------------------
     
     3.1.3 UIViewにおけるレイアウトのライフサイクル
     [UIViewオブジェクトのレイアウトライフサイクル]-----------------------------------------------
     1. 制約の更新
     2. フレームの更新
     3. レンダリング
     
     - 1. 制約の更新
     ・制約の変更によってレイアウトにおけるコンポーネントの位置関係が変更される(UIViewのupdateConstraint()が呼ばれる)
     -> 制約を満たすための再計算はレイアウトエンジンによって実行(ボトムアップ(子ビューから親ビュー)に制約計算が実行される)
     [制約更新に起因する条件]
     ⅰ. 制約のactiveフラグによる有効化および無効化
     ⅱ. 制約の優先度変更
     ⅲ. 制約の追加や削除
     ⅳ. 制約を与えられたビューの階層変更
     
     
     */
    
    
}


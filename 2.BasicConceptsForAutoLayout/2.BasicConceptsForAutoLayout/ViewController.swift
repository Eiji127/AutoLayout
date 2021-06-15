//
//  ViewController.swift
//  2.BasicConceptsForAutoLayout
//
//  Created by 白数叡司 on 2021/06/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        giveLayoutConstraint()
        fetchIntrinsicContentSize(of: button)
    }
    
    @IBAction func tapbutton(_ sender: Any) {
    }
    
    
    
    // MARK: - Note
    /*
     ### 2.1 AutoLayout=制約を用いたレイアウト方法
     2.1.1 制約
     ・制約(Constraint)：Auto Layoutで用いるインターフェースオブジェクトにおける位置やサイズの関係性を定義する概念
     → 同一階層にあるビュー同士や親子関係にあるビューの関係性を定義することが可能
     ・すべてのオブジェクトを以下のような絶対座標で定義する必要はない！！
     let rect = CGRectMake(10, 20, 130, 100)
     
     2.1.2 制約式
     ・制約の設定は以下の通り
     例：子ビューView1と親ビューsuperViewがあるとき...
     view1.top = superView.top
     view1.left = superView.left
     view1.right = superView.right
     view1.bottom = 0.8 * superView.bottom
     
     ・制約式の基本式は以下の通り！！(重要)
     y = ax + b
     
     ### 2.2 制約を定義する
     2.2.1 NSLayoutConstraint - 制約を設定するためのクラス
     [制約を定義する方法]------------------------------------
     ⅰ. NSLayoutConstraintの生成：開発者が明示的に制約オブジェクトを生成する方法
     ⅱ. Intrinsic Content Sizeの有効活用：あらかじめビューオブジェクトが持つコンテンツによって決定される制約を用いる方法
     -----------------------------------------------------
     ・NSLayoutConstraintの初期化の一部 ↓
     convenience init(item view1: AnyObject,
     attribute attr1: NSLayoutConstraint.Attribute,
     relatedBy relation: NSLayoutRelation,
     toItem view2: AnyObject?,
     attribute attr2: NSLayoutConstraint.Attribute,
     multiplier multipier: CGFloat,
     constant c: CGFloat)
     
     ・NSLayoutConstraintのインスタンス化↓
     let leftConstraint = NSLayoutConstraint(item: contentView, //制約を追加する対象ビューA
     attribute: .left, //ビューAの制約を追加する位置
     relatedBy: .equal, //ビューたちの関係性(=,≧,≦から選択)
     toItem: view, //制約を追加する対象ビューB
     attribute: .left, //ビューBの制約を追加する位置
     multiplier: 1.0, //制約式の定数a
     constant: 10.0) //制約式の定数b
     view.addConstraint(leftConstraint)
     
     ・実際にはInterface Builders上での制約追加、制約追加に関するライブラリ、ファクトリークラスを追加することで簡単に定義することが可能
     -> 問題が発生したときのために上記の基本を理解しておくべし！
     
     [NSLayoutConstraintの構成要素] -------------------------------------
     ⅰ. Item - 制約の対象となるオブジェクト
     ⅱ. Attribute - 対象となるオブジェクトの要素
     ⅲ. Constant - 制約の距離
     ⅳ. Relation - 要素の関係性
     ⅴ. Multiplier - 制約の係数
     ------------------------------------------------------------------
     ⅰ. Item - 制約の対象となるオブジェクト
     ・item = 制約を追加する対象となるインターフェースオブジェクト
     ・Itemとしては2つのオブジェクトを指定することが可能
     定義↓
     unowned var firstItem: AnyObject { get }
     unowned var secondItem: AnyObject { get }
     
     ・制約式で表すと...
     firstItem.attribute = a * secondItem.attribute + b
     
     
     ⅱ. Attribute - 対象となるオブジェクトの要素
     ・attribute = 対象となるオブジェクトのどこに対して制約を設定するのかを示す
     ・FirstItem、SecondItemに対してもAttributeを設定可能↓
     var firstAttribute: NSLayoutConstraint.Attribute { get }
     var secondAttribute: NSLayoutConstraint.Attribute { get }
     (※ NSLayoutConstraint.Attribute = 旧NSLayoutAttribute)
     ・ちなみにNSLayoutConstraint.Attributeの定義文は...↓
     public enum Attribute : Int {
     case left = 1
     case right = 2
     case top = 3
     case bottom = 4
     case leading = 5
     case trailing = 6
     case width = 7
     case height = 8
     case centerX = 9
     case centerY = 10
     case lastBaseline = 11
     
     @available(iOS 8.0, *)
     case firstBaseline = 12
     
     @available(iOS 8.0, *)
     case leftMargin = 13
     
     @available(iOS 8.0, *)
     case rightMargin = 14
     
     @available(iOS 8.0, *)
     case topMargin = 15
     
     @available(iOS 8.0, *)
     case bottomMargin = 16
     
     @available(iOS 8.0, *)
     case leadingMargin = 17
     
     @available(iOS 8.0, *)
     case trailingMargin = 18
     
     @available(iOS 8.0, *)
     case centerXWithinMargins = 19
     
     @available(iOS 8.0, *)
     case centerYWithinMargins = 20
     
     case notAnAttribute = 0
     }
     
     ⅲ. Constant - 制約の距離
     ・Constant(制約定数) = コンポーネントの相対距離やサイズを表し、以下のように宣言したもの
     var constant: CGFloat
     （例）：Button1とButton2の間の距離を10 ptとするとき、Constantが10.0となる
     ・UIViewのanimateWithDuration(_:animations:)メソッドと組み合わせると制約定数の変化をアニメーションにすることが可能
     
     ⅳ. Relation - 要素の関係性
     ・Relation(関係) = First Itemとsecond ItemのAtribute同士の関係性を示す
     var relation: NSLayoutConstraint.Relation { get }
     
     public enum Relation : Int {
     case lessThanOrEqual = -1
     case equal = 0
     case greaterThanOrEqual = 1
     }
     
     -> ex.lessThanOrEqual(≤), greaterThanOrEqual(≥)を用いるとき
     ・サイズの異なる画像を表示する際の最大サイズの定義
     ・インターフェースオブジェクトの大きさがコンテンツに合わせて変化する場合の最小のマージンの定義
     
     -> ⚠制約式に不等号を含めるときは制約不十分によるエラーが出るリスクが有り、計算コストが高くなる！
     
     ⅴ. Multiplier - 制約の係数
     ・Multiplier(倍率) = First AttributeとSecond Attributeの比率
     ・制約式「y = ax + b」のaにあたり、比率による画面レイアウトを可能にする
     var multiplier: CGFloat { get }
     
     ex. 縦横比が1:2のボタンの作成
     ex. 親ビューの20 % の高さのビューの生成
     
     - 優先度
     ・制約(Constraint)は優先度の高い順に採用されていく
     -> 論理矛盾があったときも優先度に応じてレイアウトされていく
     ・NSLayoutConstraintの優先度(Priority Level)は1~1000まで存在する
     [NSLayoutConstraintにおける優先度の定数]
     * UILayoutPriorityRequired : 優先度1000 (← 標準値)
     * UILayoutPriorityDefaultHigh : 優先度750
     * UILayoutPriorityDefaultLow : 優先度250
     * UILayoutPriorityFittingSizeLevel : 優先度50
     
     ex. あるビューオブジェクトに対して、優先度の違う高さの制約を与えるとき
     */
    let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private func giveLayoutConstraint() {
        view.addSubview(view1)
        
        // 優先度が低い制約heightConstraint1を生成追加、高さの制約定数10
        var heightConstraint1 = NSLayoutConstraint(item: view1,
                                                   attribute: NSLayoutConstraint.Attribute.height,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: nil,
                                                   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 10)
        heightConstraint1.priority = UILayoutPriority(rawValue: 500) // 優先度500に設定
        view1.addConstraint(heightConstraint1)
        
        // 優先度が高い制約heightConstraint2を生成追加、高さの制約定数20
        var heightConstraint2 = NSLayoutConstraint(item: view1,
                                                   attribute: NSLayoutConstraint.Attribute.height,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: nil,
                                                   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 20)
        heightConstraint2.priority = UILayoutPriority(rawValue: 501) // 優先度501に設定
        view.addConstraint(heightConstraint2)
        
    }
    
    /*
     ・同じ性質の制約たちが同じ優先度を持っているとき、Auto Layoutエンジンが自動的に制約を整理し、論理矛盾している制約を削除する
     
     
     2.2.2 Intrinsic Content Size - 固有の寸法
     ・UILabel, UIButton, UIImageはIntrisic Content Size(固有の寸法)を保有している
     -> Intrinsic Content Size = あるビューオブジェクトのコンテンツを圧縮、切り出しすることなく表示するための最低限必要なサイズ
     ・コンテンツを省略せずに正しいレイアウトを保つことが可能
     
     ex. オブジェクトのIntrinsic Content Sizeを取得する方法
     */
    private func fetchIntrinsicContentSize(of object: UIView) {
        print("DEBUG : " + NSCoder.string(for: object.intrinsicContentSize))
    }
    /*
     fetchIntrinsicContentSize(of: button)の出力結果 : DEBUG : {46, 30}
     
     -> コンテンツの大きさに合わせてオブジェクトのサイズを調整することが可能
     -> 実践においてもIntrinsic Content Sizeは多くの場面で活躍している！！
     ex. UILabelとUITableViewを組みあせたFacebook, Twitterクライアントなどが該当する
     
     
     2.2.3 Content Hugging PriorityとContent Compression Resistence Priority - コンテンツに対する優先度
     ・Content Hugging Priority : 制約の一種(大きくなりにくさ) = コンテンツに沿う優先度
     -> コンテンツのIntrinsic Content Sizeに合わせてレイアウト時のフレームのサイズを変化させる
     ・Content Compression Resistence Priority : 制約の一種(小さくなりにくさ) = コンテンツの圧縮抵抗優先度
     -> コンテンツに反して圧縮されないかどうかの優先度
     
     
     */
    
}

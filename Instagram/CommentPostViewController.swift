//
//  CommentPostViewController.swift
//  Instagram
//
//  Created by 川目悠貴 on 2021/04/25.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentPostViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    var postData: PostData! //課題
    var image: UIImage!
    //コメント投稿ボタンを押した時に呼ばれるメソッド
    @IBAction func commentPostButton(_ sender: Any) {
        
        let name = Auth.auth().currentUser?.displayName
        var updateValue: FieldValue
        updateValue = FieldValue.arrayUnion([name! + ":" + textField.text!])
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        postRef.updateData(["comments": updateValue])
        
        
        //HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        //投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    //キャンセルボタンをタップした時に呼ばれるメソッド
    @IBAction func commentCancelButton(_ sender: Any) {
        //前の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        //受け取った画像をImageViewに設定する
        imageView.image = image
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func dismissKeyboard(){
        //キーボードを閉じる
        view.endEditing(true)
    }
}

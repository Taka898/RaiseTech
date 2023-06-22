# 第6回課題

## 最後にAWSを利用した日の記録をCloudTrailのイベントから探し出す
- CloudTrailのイベント履歴から自分のIAMユーザーで最後に利用した日のイベントを確認
![CloudTrailのイベント](images/lecture06_cloudtrail.png)
- イベント名と、含まれている内容3つをピックアップ
    - イベント名：StartSession
    - 含まれている内容
        - イベント時間
        - 発信元IPアドレス
        - イベントレコード

## CloudWatchアラームを使って、ALBのアラームを設定し、メール通知する
### アラームとアクションを設定する
- ALBのターゲットグループが「正常」「異常」を監視するアラームを設定
- SNSでメールを送信するアクションを設定
![SNS](images/lecture06_sns.png)

### Railsアプリケーションが使えない状態で動作を確認する
- Nginxを停止
- ターゲットグループのヘルスステータスが「異常」になっていることを確認
![ターゲットグループNG](images/lecture06_tg_ng.png)
- CloudWatchでアラーム状態になっていることを確認
![CloudWatchアラーム状態01](images/lecture06_alarm_01.png)
![CloudWatchアラーム状態02](images/lecture06_alarm_02.png)
![CloudWatchアラーム状態03](images/lecture06_alarm_03.png)
- SNSで指定したメールアドレス宛にメールが届いていることを確認
![ALARMメール](images/lecture06_mail_alarm.png)

### Railsアプリケーションが使える状態で動作を確認する
- Nginxを起動
- ターゲットグループのヘルスステータスが「正常」になっていることを確認
![ターゲットグループOK](images/lecture06_tg_ok.png)
- CloudWatchでOK状態になっていることを確認
![CloudWatchOK状態01](images/lecture06_alarm_ok_01.png)
![CloudWatchOK状態02](images/lecture06_alarm_ok_02.png)
![CloudWatchOK状態03](images/lecture06_alarm_ok_03.png)
- SNSで指定したメールアドレス宛にメールが届いていることを確認
![OKメール](images/lecture06_mail_ok.png)

## AWS利用料の見積を作成する
- 今日までに作成したリソースの内容の見積<br>
[My Estimate](https://calculator.aws/#/estimate?id=08f16b517723506f91ca8c3a65e99ab34f193f0b)

## マネジメントコンソールから、現在の利用料を確認する
- 先月の請求情報から、EC2の料金がいくらか、無料利用枠で収まっているか確認
![先月の請求情報](images/lecture06_billing_01.png)
![EC2の料金](images/lecture06_billing_02.png)

## 今回の課題から学んだことを報告する
- AWSだけでログ出力や監視・通知などができることに驚いた
- 有効化しないと出力されないログがあるので設定を忘れないようにしたい
- バッチジョブやジョブの実行監視などのAWSでのセオリーが気になった
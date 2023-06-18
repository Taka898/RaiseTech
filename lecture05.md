# 第5回課題

## EC2上にサンプルアプリケーションをデプロイして、動作させる
### 組み込みサーバーだけで動作させる
1. 〜
- 〜を確認
![〜](images/xxx.png)


- New Fluitから入力し反映されることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_puma.png)

### サーバーアプリケーションを分ける


- Nginxが起動していることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_nginx.png)


- New Fluitから入力し反映されることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_unicorn.png)

## ELB(ALB)を追加する
### ELB(ALB)を作成する
- ELB(ALB)が作成されていることを確認
![ELBの画面1](images/lecture05_elb_01.png)
![ELBの画面2](images/lecture05_elb_02.png)
![ELBの画面3](images/lecture05_elb_03.png)
![ELBの画面4](images/lecture05_elb_04.png)
- ELB(ALB)のターゲットグループを確認
![ターゲットグループの画面1](images/lecture05_elb_tg_01.png)
![ターゲットグループの画面2](images/lecture05_elb_tg_02.png)
- ELB(ALB)のセキュリティグループを確認
![セキュリティグループの画面](images/lecture05_elb_sg.png)

### ELB(ALB)のDNS名でアクセスできるか確認する
- DNS名でアクセスし、New Fluitから入力し反映されることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_elb.png)

## S3を追加する
- バケットを作成
![バケット](images/lecture05_s3.png)


- New Fluitから入力し反映されることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_s3.png)

- バケットに保存されていることを確認
![バケットのオブジェクト](images/lecture05_s3_object.png)

## 環境を構成図に書き起こす
- 書き起こした構成図
![構成図](images/Lecture05_drawio.png)

## 今回の課題から学んだことを報告する
- サーバやDBがウィザードだけで簡単に作成できたことに改めて驚いた
- 特にインターネットにつながるネットワークがAWSにほぼお任せでできることに驚き
- 次はサブネットやセキュリティグループを自分で作成後に関連付けてみて理解を深めたい

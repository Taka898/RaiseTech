# 第5回課題

## EC2上にサンプルアプリケーションをデプロイして、動作させる
### 組み込みサーバーだけで動作させる
1. 〜
- 〜を確認
![〜](images/xxx.png)


- New Fruitから入力し反映されることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_puma.png)

### サーバーアプリケーションを分ける


- Nginxが起動していることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_nginx.png)


- New Fruitから入力し反映されることを確認
![サンプルアプケーションの反映後画面](images/lecture05_sampleApp_unicorn.png)

## ELB(ALB)を追加する
1. ELB(ALB)を作成する
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

2. `development.rb`にELB(ALB)のDNS名を追加する
    - `development.rb`の設定を変更
    
    ```
    # 'development.rb'があるディレクトリに移動
    $ cd /var/www/raisetech-live8-sample-app/config/environments
    
    # 'development.rb'を編集
    $ vim development.rb
    
    config.hosts << "ELB(ALB)のDNS名"
    ```

3. ELB(ALB)のDNS名でアクセスできるか確認する
    - DNS名でアクセスし、New Fruitから入力し反映されることを確認
    ![ELB(ALB)追加後の画面](images/lecture05_sampleApp_elb.png)

## S3を追加する
1. バケットを作成する
    - バケットが作成されていることを確認
    ![バケット](images/lecture05_s3.png)

2. S3にアクセスするためのIAMユーザーを作成する
    - IAMユーザーを作成しアクセスキーが作成されていることを確認
    ![バケット](images/lecture05_s3_iam.png)

3. Railsの設定を変更する
    - サンプルアプリケーションのGemfileに`aws-sdk-s3`が記述されていることを確認
    - 秘匿情報に作成したアクセスキーを設定

    ```
    # 設定ファイルがあるディレクトリに移動
    $ cd /var/www/raisetech-live8-sample-app/config/credentials/
    
    # 設定ファイルの削除
    $ rm development.yml.enc
    
    # 設定ファイルの作成
    $ EDITOR=vim rails credentials:edit --environment development
    
    aws:
      access_key_id: 作成したアクセスキーID
      secret_access_key: 作成したシークレットアクセスキー
      active_storage_bucket_name: 作成したバケットの名前
    ```

    - `development.rb`の設定を変更
    
    ```
    # 'development.rb'があるディレクトリに移動
    $ cd /var/www/raisetech-live8-sample-app/config/environments
    
    # 'development.rb'を編集
    $ vim development.rb
    
    config.active_storage.service = :amazon
    ```

4. New Fruitから入力し反映され、バケットに保存されていることを確認する
    - New Fruitから入力し反映されることを確認
    ![S3追加後の画面](images/lecture05_sampleApp_s3.png)

    - バケットに保存されていることを確認
    ![バケットのオブジェクト](images/lecture05_s3_object.png)

## 環境を構成図に書き起こす
![構成図](images/Lecture05_drawio.png)

## 今回の課題から学んだことを報告する
- サーバやDBがウィザードだけで簡単に作成できたことに改めて驚いた
- 特にインターネットにつながるネットワークがAWSにほぼお任せでできることに驚き
- 次はサブネットやセキュリティグループを自分で作成後に関連付けてみて理解を深めたい

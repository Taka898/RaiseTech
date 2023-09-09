# 第13,14回課題

## 課題
### 第13回課題
> CircleCI のサンプルに ServerSpec や Ansible の処理を追加してください。
### 第14回課題
> これまでの AWS 構成図、自動化処理がわかる図、リポジトリの README を作りましょう。

## 対応内容
- 第12回課題のCircleCIに以下処理を追加
  - 第10回課題で作成したCloudFormationテンプレートを実行する処理
  - 第5回課題で実施したサンプルアプリケーションのデプロイをコード化したAnsibleの処理
  - 第11回課題で作成したServerspecのテストスクリプトをSSH実行するようにした処理
- 第5回課題で作成したAWS構成図に自動化処理の図を追加
- リポジトリのREADMEを作成

## 結果
### CircleCIにCloudFormation、Ansible、Serverspecの処理を追加する
- .circleci/config.ymlにAWS CLIでCloudFormationテンプレートを実行する処理を追加
```
# 一部抜粋

jobs:

  cfn-execute:
    executor: aws-cli/default
    steps:
      - checkout
      - aws-cli/setup:
          aws-access-key-id: AWS_ACCESS_KEY_ID
          aws-region: AWS_DEFAULT_REGION
          aws-secret-access-key: AWS_SECRET_ACCESS_KEY
      - run: aws cloudformation deploy --template-file cloudformation/01_vpc.yml --stack-name cfn-lecture-vpc
      - run: aws cloudformation deploy --template-file cloudformation/02_ec2.yml --stack-name cfn-lecture-ec2 --parameter-overrides SSHCidrIp="${AWS_SSH_MY_IP}"
      - run: aws cloudformation deploy --template-file cloudformation/03_rds.yml --stack-name cfn-lecture-rds --parameter-overrides DBPassword="${AWS_DB_PW}"
      - run: aws cloudformation deploy --template-file cloudformation/04_elb.yml --stack-name cfn-lecture-elb
      - run: aws cloudformation deploy --template-file cloudformation/05_s3.yml --stack-name cfn-lecture-s3
```
- .circleci/config.ymlにAnsibleのPlaybookを実行する処理を追加
```
# 一部抜粋

jobs:

  ansible-execute:
    executor: ansible/default
    steps:
      - checkout
      - run:
          name: Copy SSH Config
          command: cp sshconfig/config ~/.ssh/
      - ansible/install:
          version: 2.9.23
      - ansible/playbook:
          playbook: ansible/playbook.yml
          playbook-options: "-i ansible/inventory"
```
- .circleci/config.ymlにServerspecのテストスクリプトを実行する処理を追加
```
# 一部抜粋

jobs:

  serverspec-execute:
    docker:
      - image: cimg/ruby:2.7-node
    steps:
      - checkout
      - run:
          name: Copy SSH Config
          command: cp sshconfig/config ~/.ssh/
      - run:
          name: bundle install
          command: |
            cd serverspec
            gem list -e rails
            bundle install --path vendor/bundle
      - run:
          name: execute
          command: |
            cd serverspec
            bundle exec rake spec
```
### GitHubにプッシュし、CircleCIで正常終了することを確認する
- CircleCIの実行結果



### CircleCI のサンプルコンフィグをリポジトリに組み込む
1. `.circleci/config.yml`をサンプルコンフィグの内容で置き換え
2. GitHubにプッシュ

### サンプルコンフィグが正しく動作していることを確認する
- CircleCIの実行結果
![CircleCIの実行結果](images/lecture12_circleci.png)

### （補足）発生したエラー
``` 
W3005 Obsolete DependsOn on resource (CFnVPCIGW), dependency already enforced by a "Ref" at Resources/PublicRoute/Properties/GatewayId/Ref
cloudformation/01_vpc.yml:102:5
```
- `Ref`の指定で依存関係が適用されているため`DependsOn`は不要
  - （対応）`DependsOn`の指定を削除

```
W2031 You must specify a valid Default value for SSHCidrIp (x.x.x.x/x). Valid values must match pattern x.x.x.x/y
cloudformation/02_ec2.yml:16:5
```
- `SSHCidrIp`に指定されているデフォルト値が`x.x.x.x/y`のパターンに一致しない
  - （対応）デフォルト値を`255.255.255.255/32`に変更

## 今回の課題から学んだことを報告する
- CircleCIとGitHubがどのように連携して動いているのかイメージできた
  - GitHubの`.circleci/config.yml`に実行したいjobを定義することで、CircleCI上で実行されるなど
- 今回は構文チェックだけだが、自動テストやビルドも試してみたい
- 公式ドキュメントが日本語化されていて内容も充実してそうなので、どんなことができるか確認したい

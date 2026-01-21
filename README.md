# AWS DevOps Agent ハンズオン環境

AWS DevOps Agent × FIS ハンズオン用の環境構築スクリプトです。

## アーキテクチャ

![Architecture](./architecture.drawio)

※ draw.io で開くと編集可能な構成図を確認できます。

## 作成されるリソース

| リソース                | 名前                               | 用途                           |
| ----------------------- | ---------------------------------- | ------------------------------ |
| VPC                     | devops-agent-handson-vpc           | EC2 用ネットワーク             |
| Internet Gateway        | devops-agent-handson-igw           | インターネット接続（SSM 用）   |
| Public Subnet           | devops-agent-handson-subnet        | EC2 配置用                     |
| Route Table             | devops-agent-handson-rtb           | ルーティング                   |
| Security Group          | devops-agent-handson-sg            | EC2 用（アウトバウンドのみ許可）|
| IAM Role (EC2用)        | devops-agent-handson-ec2-role      | SSM Agent 用                   |
| IAM Instance Profile    | devops-agent-handson-ec2-profile   | EC2 にロールをアタッチ         |
| EC2 Instance            | devops-agent-handson-ec2           | CPU 負荷をかける対象           |
| IAM Role (FIS用)        | devops-agent-handson-fis-role      | FIS 実験実行用                 |
| FIS Experiment Template | devops-agent-handson-cpu-stress    | CPU Stress 実験                |
| CloudWatch Alarm        | devops-agent-handson-cpu-alarm     | CPU 高負荷検知                 |

## 使い方

### 前提条件

- AWS CLI v2 がインストールされていること
- AWS 認証情報が設定されていること（`aws login` など）

### セットアップ

```bash
chmod +x setup.sh
./setup.sh
```

### クリーンアップ

```bash
chmod +x cleanup.sh
./cleanup.sh
```

## 注意事項

- リージョンは `us-east-1` 固定です
- ハンズオン終了後は必ず `cleanup.sh` を実行してリソースを削除してください

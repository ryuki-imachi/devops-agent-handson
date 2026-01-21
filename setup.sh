#!/bin/bash
set -e

STACK_NAME="devops-agent-handson"
REGION="us-east-1"

echo "=== AWS DevOps Agent ハンズオン環境をセットアップします ==="
echo ""

# スタックの作成
echo "CloudFormation スタックを作成中..."
aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://template.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --region $REGION

# 作成完了を待機
echo "スタック作成完了を待機中（3〜5分かかります）..."
aws cloudformation wait stack-create-complete \
  --stack-name $STACK_NAME \
  --region $REGION

# 作成されたリソースを表示
echo ""
echo "=== 作成されたリソース ==="
aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --region $REGION \
  --query 'Stacks[0].Outputs' \
  --output table

echo ""
echo "=== セットアップ完了 ==="
echo "EC2 が SSM に登録されるまで 2〜3 分お待ちください。"
echo ""
echo "以下のコマンドで SSM 登録状況を確認できます:"
echo "  aws ssm describe-instance-information --region $REGION --query 'InstanceInformationList[].[InstanceId,PingStatus]' --output table"

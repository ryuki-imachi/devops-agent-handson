#!/bin/bash
set -e

STACK_NAME="devops-agent-handson"
REGION="us-east-1"

echo "=== AWS DevOps Agent ハンズオン環境を削除します ==="
echo ""

# 実行中の FIS 実験があれば停止
echo "実行中の FIS 実験を確認中..."
RUNNING_EXPERIMENTS=$(aws fis list-experiments \
  --region $REGION \
  --query "experiments[?state.status=='running'].id" \
  --output text 2>/dev/null || true)

if [ -n "$RUNNING_EXPERIMENTS" ]; then
  echo "実行中の実験を停止します: $RUNNING_EXPERIMENTS"
  for exp_id in $RUNNING_EXPERIMENTS; do
    aws fis stop-experiment --id $exp_id --region $REGION || true
  done
  echo "実験を停止しました"
fi

# スタックの削除
echo ""
echo "CloudFormation スタックを削除中..."
aws cloudformation delete-stack \
  --stack-name $STACK_NAME \
  --region $REGION

# 削除完了を待機
echo "スタック削除完了を待機中..."
aws cloudformation wait stack-delete-complete \
  --stack-name $STACK_NAME \
  --region $REGION

echo ""
echo "=== クリーンアップ完了 ==="
echo "すべてのリソースが削除されました。"

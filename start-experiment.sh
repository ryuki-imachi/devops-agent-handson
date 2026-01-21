#!/bin/bash
set -e

REGION="us-east-1"

echo "=== FIS 実験を開始します ==="
echo ""

# 実験テンプレート ID を取得
echo "実験テンプレートを検索中..."
TEMPLATE_ID=$(aws fis list-experiment-templates --region $REGION --query "experimentTemplates[?tags.Name=='devops-agent-handson-cpu-stress'].id" --output text)

if [ -z "$TEMPLATE_ID" ]; then
  echo "エラー: 実験テンプレートが見つかりません。setup.sh を実行してください。"
  exit 1
fi

echo "テンプレート ID: $TEMPLATE_ID"
echo ""

# 実験を開始
echo "実験を開始中..."
EXPERIMENT_ID=$(aws fis start-experiment --experiment-template-id $TEMPLATE_ID --region $REGION --query 'experiment.id' --output text)

echo "実験 ID: $EXPERIMENT_ID"
echo ""

# 実験の状態を確認
echo "=== 実験の状態 ==="
aws fis get-experiment --id $EXPERIMENT_ID --region $REGION --query 'experiment.[id,state.status]' --output table

echo ""
echo "=== 実験が開始されました ==="
echo "CPU 負荷が 5 分間発生します。"
echo ""
echo "CloudWatch アラームの状態を確認するには:"
echo "  aws cloudwatch describe-alarms --alarm-names devops-agent-handson-cpu-alarm --region us-east-1 --query 'MetricAlarms[].[AlarmName,StateValue]' --output table"

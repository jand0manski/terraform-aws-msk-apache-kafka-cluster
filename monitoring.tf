resource "aws_cloudwatch_metric_alarm" "msk_broker_disk_space" {
  count = var.create_alarm ? var.broker_per_zone * length(var.subnet_ids):0
  alarm_name                = "msk-${var.name}-HighDiskUsed-Broker-${count.index + 1}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "RootDiskUsed"
  namespace                 = "AWS/Kafka"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = var.disk_threshold
  alarm_description         = "This metric monitors high disk used"
  actions_enabled = true
  ok_actions          = [var.sns_topic_arn]
  insufficient_data_actions = [var.sns_topic_arn]
  alarm_actions = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.name
    "Broker ID"    = count.index + 1
  }
}
resource "aws_cloudwatch_metric_alarm" "msk_broker_memory" {
  count = var.create_alarm ? var.broker_per_zone * length(var.subnet_ids):0
  alarm_name                = "msk-${var.name}-HighMemoryUsed-Broker-${count.index + 1}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "HeapMemoryAfterGC"
  namespace                 = "AWS/Kafka"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = var.memory_threshold_percent
  alarm_description         = "HighMemoryUsed-Broker"
  ok_actions          = [var.sns_topic_arn]
  insufficient_data_actions = [var.sns_topic_arn]
  actions_enabled = true
  alarm_actions = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.name
    "Broker ID"    = count.index + 1
  }
}
resource "aws_cloudwatch_metric_alarm" "msk_broker_cpu" {
  count = var.create_alarm ? var.broker_per_zone * length(var.subnet_ids):0
  alarm_name                = "msk-${var.name}-HighCpuUsed-Broker-${count.index + 1}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "CpuSystem"
  namespace                 = "AWS/Kafka"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = var.cpu_threshold
  alarm_description         = "HighCpu-Used-Broker"
  ok_actions          = [var.sns_topic_arn]
  insufficient_data_actions = [var.sns_topic_arn]
  actions_enabled = true
  alarm_actions = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.name
    "Broker ID"    = count.index + 1
  }
}

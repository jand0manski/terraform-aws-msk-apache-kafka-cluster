resource "aws_cloudwatch_metric_alarm" "msk_broker_disk_space" {
  count = var.create_alarm ? var.broker_per_zone * length(var.subnet_ids):0
  alarm_name                = "${var.name}-HighDiskUsed-Broker-${count.index + 1}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "RootDiskUsed"
  namespace                 = "AWS/Kafka"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = var.disk_threshold
  alarm_description         = "This metric monitors high disk used"
  insufficient_data_actions = []
  actions_enabled = true
  alarm_actions = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.name
    "Broker ID"    = count.index + 1
  }
}
resource "aws_cloudwatch_metric_alarm" "msk_broker_memory" {
  count = var.create_alarm ? var.broker_per_zone * length(var.subnet_ids):0
  alarm_name                = "${var.name}-HighMemoryUsed-Broker-${count.index + 1}"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "MemoryFree"
  namespace                 = "AWS/Kafka"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = var.memory_threshold_bytes_free
  alarm_description         = "HighMemoryUsed-Broker"
  insufficient_data_actions = []
  actions_enabled = true
  alarm_actions = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.name
    "Broker ID"    = count.index + 1
  }
}
resource "aws_cloudwatch_metric_alarm" "msk_broker_cpu" {
  count = var.create_alarm ? var.broker_per_zone * length(var.subnet_ids):0
  alarm_name                = "${var.name}-HighCpuUsed-Broker-${count.index + 1}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "CpuSystem"
  namespace                 = "AWS/Kafka"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = var.cpu_threshold
  alarm_description         = "HighCpu-Used-Broker"
  insufficient_data_actions = []
  actions_enabled = true
  alarm_actions = [var.sns_topic_arn]
  dimensions = {
    "Cluster Name" = var.name
    "Broker ID"    = count.index + 1
  }
}

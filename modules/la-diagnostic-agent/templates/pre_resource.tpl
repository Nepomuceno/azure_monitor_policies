{
  "StorageAccount": "${storagename}",
  "ladCfg": {
    "diagnosticMonitorConfiguration": {
      "eventVolume": "Medium", 
      "metrics": {
        "metricAggregation": [
          {
            "scheduledTransferPeriod": "PT1H"
          }, 
          {
            "scheduledTransferPeriod": "PT1M"
          }
        ], 
        "resourceId": "
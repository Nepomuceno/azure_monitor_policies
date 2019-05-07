{
  "storageAccountName": "{storagename}",
  "storageAccountSasToken": "{storagesasToken}",
  "sinksConfig": {
    "sink": [
      {
        "name": "logJsonBlob",
        "type": "JsonBlob"
      },
      {
        "name": "eventHubsLogs",
        "type": "EventHub",
        "sasURL": "{eh_sas_url}"
      }
    ]
  }
}
[
              {
                "field": "Microsoft.Compute/imageId",
                "in": "[parameters('listOfImageIdToInclude')]"
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftWindowsServer"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "equals": "WindowsServer"
                  },
                  {
                    "field": "Microsoft.Compute/imageSKU",
                    "in": [
                      "2008-R2-SP1",
                      "2008-R2-SP1-smalldisk",
                      "2012-Datacenter",
                      "2012-Datacenter-smalldisk",
                      "2012-R2-Datacenter",
                      "2012-R2-Datacenter-smalldisk",
                      "2016-Datacenter",
                      "2016-Datacenter-Server-Core",
                      "2016-Datacenter-Server-Core-smalldisk",
                      "2016-Datacenter-smalldisk",
                      "2016-Datacenter-with-Containers",
                      "2016-Datacenter-with-RDSH",
                      "2019-Datacenter",
                      "2019-Datacenter-Core",
                      "2019-Datacenter-Core-smalldisk",
                      "2019-Datacenter-Core-with-Containers",
                      "2019-Datacenter-Core-with-Containers-smalldisk",
                      "2019-Datacenter-smalldisk",
                      "2019-Datacenter-with-Containers",
                      "2019-Datacenter-with-Containers-smalldisk",
                      "2019-Datacenter-zhcn"
                    ]
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftWindowsServer"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "equals": "WindowsServerSemiAnnual"
                  },
                  {
                    "field": "Microsoft.Compute/imageSKU",
                    "in": [
                      "Datacenter-Core-1709-smalldisk",
                      "Datacenter-Core-1709-with-Containers-smalldisk",
                      "Datacenter-Core-1803-with-Containers-smalldisk"
                    ]
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftWindowsServerHPCPack"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "equals": "WindowsServerHPCPack"
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftSQLServer"
                  },
                  {
                    "anyOf": [
                      {
                        "field": "Microsoft.Compute/imageOffer",
                        "like": "*-WS2016"
                      },
                      {
                        "field": "Microsoft.Compute/imageOffer",
                        "like": "*-WS2016-BYOL"
                      },
                      {
                        "field": "Microsoft.Compute/imageOffer",
                        "like": "*-WS2012R2"
                      },
                      {
                        "field": "Microsoft.Compute/imageOffer",
                        "like": "*-WS2012R2-BYOL"
                      }
                    ]
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftRServer"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "equals": "MLServer-WS2016"
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftVisualStudio"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "in": [
                      "VisualStudio",
                      "Windows"
                    ]
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftDynamicsAX"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "equals": "Dynamics"
                  },
                  {
                    "field": "Microsoft.Compute/imageSKU",
                    "equals": "Pre-Req-AX7-Onebox-U8"
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "microsoft-ads"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "equals": "windows-data-science-vm"
                  }
                ]
              },
              {
                "allOf": [
                  {
                    "field": "Microsoft.Compute/imagePublisher",
                    "equals": "MicrosoftWindowsDesktop"
                  },
                  {
                    "field": "Microsoft.Compute/imageOffer",
                    "equals": "Windows-10"
                  }
                ]
              }
            ]
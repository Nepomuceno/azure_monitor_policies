[
                            {
                                "field": "Microsoft.Compute/imagePublisher",
                                "in": [
                                    "microsoft-aks",
                                    "AzureDatabricks",
                                    "qubole-inc",
                                    "datastax",
                                    "couchbase",
                                    "scalegrid",
                                    "checkpoint",
                                    "paloaltonetworks"
                                ]
                            },
                            {
                                "field": "Microsoft.Compute/imageId",
                                "in": "[parameters('listOfImageIdToInclude')]"
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "OpenLogic"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "like": "CentOS*"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageSKU",
                                        "notLike": "6*"
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "RedHat"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "equals": "RHEL"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageSKU",
                                        "notLike": "6*"
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "RedHat"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "equals": "osa"
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "credativ"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "equals": "Debian"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageSKU",
                                        "notLike": "7*"
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "Suse"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "like": "SLES*"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageSKU",
                                        "notLike": "11*"
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "Canonical"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "equals": "UbuntuServer"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageSKU",
                                        "notLike": "12*"
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "microsoft-dsvm"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "in": [
                                            "linux-data-science-vm-ubuntu",
                                            "azureml"
                                        ]
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "cloudera"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "equals": "cloudera-centos-os"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageSKU",
                                        "notLike": "6*"
                                    }
                                ]
                            },
                            {
                                "allOf": [
                                    {
                                        "field": "Microsoft.Compute/imagePublisher",
                                        "equals": "cloudera"
                                    },
                                    {
                                        "field": "Microsoft.Compute/imageOffer",
                                        "equals": "cloudera-altus-centos-os"
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
                                        "like": "linux*"
                                    }
                                ]
                            }
                        ]
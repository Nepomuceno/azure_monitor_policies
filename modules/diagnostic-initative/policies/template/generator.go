package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

// Entity base resource entity
type Entity struct {
	Name          string
	ResourceType  string
	Logs          []string
	Enablemetrics bool
}

func main() {
	content := []Entity{
		Entity{
			Name:          "eventhubs",
			ResourceType:  "Microsoft.EventHub/namespaces",
			Logs:          []string{"ArchiveLogs", "OperationalLogs", "AutoScaleLogs"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "nsg",
			ResourceType:  "Microsoft.Network/networksecuritygroups",
			Logs:          []string{"NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "loadbalancer",
			ResourceType:  "Microsoft.Network/loadBalancers",
			Logs:          []string{"LoadBalancerAlertEvent", "LoadBalancerProbeHealthStatus"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "publicip",
			ResourceType:  "Microsoft.Network/publicIPAddresses",
			Logs:          []string{"DDoSProtectionNotifications", "DDoSMitigationFlowLogs", "DDoSMitigationReports"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "virtualnetwork",
			ResourceType:  "Microsoft.Network/virtualNetworks",
			Logs:          []string{"VMProtectionAlerts"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "applicationgateway",
			ResourceType:  "Microsoft.Network/applicationGateways",
			Logs:          []string{"ApplicationGatewayAccessLog", "ApplicationGatewayPerformanceLog", "ApplicationGatewayFirewallLog"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "securegateways",
			ResourceType:  "Microsoft.Network/securegateways",
			Logs:          []string{"AzureFirewallApplicationRule", "AzureFirewallNetworkRule"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "applicationfirewall",
			ResourceType:  "Microsoft.Network/azurefirewalls",
			Logs:          []string{"AzureFirewallApplicationRule", "AzureFirewallNetworkRule"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "gateway",
			ResourceType:  "Microsoft.Network/virtualNetworkGateways",
			Logs:          []string{"GatewayDiagnosticLog", "TunnelDiagnosticLog", "RouteDiagnosticLog", "IKEDiagnosticLog", "P2SDiagnosticLog"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "traficmanager",
			ResourceType:  "Microsoft.Network/trafficManagerProfiles",
			Logs:          []string{"ProbeHealthStatusEvents"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "gateway",
			ResourceType:  "Microsoft.Network/virtualNetworkGateways",
			Logs:          []string{"GatewayDiagnosticLog", "TunnelDiagnosticLog", "RouteDiagnosticLog", "IKEDiagnosticLog", "P2SDiagnosticLog"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "expressroute",
			ResourceType:  "Microsoft.Network/expressRouteCircuits",
			Logs:          []string{"PeeringRouteLog"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "frontdoor",
			ResourceType:  "Microsoft.Network/frontdoors",
			Logs:          []string{"FrontdoorAccessLog","FrontdoorWebApplicationFirewallLog"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "powerbi",
			ResourceType:  "Microsoft.PowerBIDedicated/capacities",
			Logs:          []string{"Engine"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "backupvault",
			ResourceType:  "Microsoft.RecoveryServices/Vaults",
			Logs:          []string{"AzureBackupReport", "AzureSiteRecoveryJobs", "AzureSiteRecoveryEvents", "AzureSiteRecoveryReplicatedItems", "AzureSiteRecoveryReplicationStats", "AzureSiteRecoveryRecoveryPoints", "AzureSiteRecoveryReplicationDataUploadRate", "AzureSiteRecoveryProtectedDiskDataChurn"},
			Enablemetrics: false,
		},
		Entity{
			Name:          "search",
			ResourceType:  "Microsoft.RecoveryServices/Vaults",
			Logs:          []string{"OperationLogs"},
			Enablemetrics: true,
		},
		Entity{
			Name:          "servicebus",
			ResourceType:  "Microsoft.ServiceBus/namespaces",
			Logs:          []string{"OperationLogs"},
			Enablemetrics: true,
		},
	}
	dat, err := ioutil.ReadFile("./log.json")
	check(err)
	jsonTemplate := string(dat)
	dat, err = ioutil.ReadFile("./metrics.json")
	check(err)
	metricsTemplate := string(dat)
	dat, err = ioutil.ReadFile("./base-rule.json")
	check(err)
	ruleTemplate := string(dat)
	dat, err = ioutil.ReadFile("./base-parameter.json")
	check(err)
	parameterTemplate := dat
	available := []string{}
	for _, entity := range content {
		logs := []string{}
		for _, logCategory := range entity.Logs {
			logs = append(logs, strings.ReplaceAll(jsonTemplate, "$$CATEGORY$$", logCategory))
		}
		contentTemplate := ruleTemplate
		if entity.Enablemetrics {
			contentTemplate = strings.ReplaceAll(contentTemplate, "\"$$METRICS$$\"", metricsTemplate)
		} else {
			contentTemplate = strings.ReplaceAll(contentTemplate, "\"$$METRICS$$\"", "")
		}
		contentTemplate = strings.ReplaceAll(contentTemplate, "$$TYPE$$", entity.ResourceType)
		contentTemplate = strings.ReplaceAll(contentTemplate, "\"$$LOGS$$\"", strings.Join(logs, ",\n"))
		
		var v interface{}
		available = append(available,fmt.Sprintf("\"%s\"",entity.Name))
		json.Unmarshal([]byte(contentTemplate),&v)
		jsonData, error := json.MarshalIndent(v, "", "    ")
		check(error)
		folderpath := fmt.Sprintf("../%s/",entity.Name)
		os.MkdirAll(folderpath, os.ModePerm)
		ruleFileName := fmt.Sprintf("../%s/rule.json",entity.Name)
		parametersFileName := fmt.Sprintf("../%s/parameters.json",entity.Name)
		fmt.Printf("Writing %s files\n",entity.Name)
		ioutil.WriteFile(ruleFileName,jsonData,os.ModePerm)
		ioutil.WriteFile(parametersFileName,parameterTemplate,os.ModePerm)
	}
	fmt.Printf("[%s]",strings.Join(available,",\n"))

	os.Exit(0)
}

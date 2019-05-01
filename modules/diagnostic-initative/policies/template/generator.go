package main

import (
	"strings"
	"fmt"
	"io/ioutil"
	"os"
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
			Name: "eventhubs",
			ResourceType: "Microsoft.EventHub/namespaces",
			Logs: []string{"ArchiveLogs","OperationalLogs","AutoScaleLogs"},
			Enablemetrics: true,
		},
	}
	dat, err := ioutil.ReadFile("./log.json")
	jsonTemplate := string(dat)
	for _, entity := range content {
		logs := []string{}
		for _, logCategory := range entity.Logs {
			logs = append(logs,strings.ReplaceAll(jsonTemplate,"$$CATEGORY$$",logCategory))
		}
		fmt.Println(strings.Join(logs, ",\n"))
	}
	fmt.Println("Hello")
	
	check(err)
	fmt.Print(jsonTemplate)

	os.Exit(0)
}

package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"strconv"

	"github.com/splendidmoons/suriya-go"
)

func main() {
	f, err := os.Open("./data/calendar.csv")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	reader := csv.NewReader(f)
	reader.FieldsPerRecord = 2

	rows, _ := reader.ReadAll()

	var calendarYear int
	for _, row := range rows {
		if row[0] == "year" {
			calendarYear, _ = strconv.Atoi(row[1])
		}
	}

	days := suriya.GenerateSolarYear(calendarYear)
	for _, d := range days {
		fmt.Printf("%s,%s,%s\n", d.Date.Format("2006-01-02"), d.Phase, d.Event)
	}
}

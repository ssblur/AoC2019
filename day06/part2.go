package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

// traceRoute is essentially getDepth. I originally intended to make changes, but didn't.
// It returns an integer representing body's depth.
func traceRoute(depth map[string]int, body string, relationships [][]string) int {
	if _, ok := depth[body]; !ok {
		for _, v := range relationships{
			if(v[1] == body) {
				depth[body] = traceRoute(depth, v[0], relationships) + 1
			}
		}
	}
	return depth[body]
}

func main() {
	bytes, e := ioutil.ReadFile("./input.txt")
	if(e != nil) { panic(e) }
	input := strings.Split(string(bytes), "\r\n")

	relationships := [][]string{}
	for _, v := range input {
		relationships = append(relationships, strings.Split(v, ")"))
	}

	you := map[string]int{}
	san := map[string]int{}
	you["COM"] = 0
	san["COM"] = 0

	// This time, we're only concerned with building out the depths of all nodes connected to YOU and SAN.
	// Once we know those, we can:
	// * find the highest common depth shared by both of you
	// * remove that node's depth from both of your nodes, and 
	// * add the depth of the bodies you and Santa orbit
	// And that should produce the same number of the minimum number of orbital transfers required.
	for _, v := range relationships {
		parent, child := v[0], v[1]
		if child == "YOU" {
			you["YOU"] = traceRoute(you, parent, relationships) // We are actually not going to add 1 depth to make calculations simpler later.
		} else if child == "SAN" {
			san["SAN"] = traceRoute(san, parent, relationships)
		}
	}

	// Find nodes which you both orbit indirectly.
	shared := map[string]int{}
	for k, v := range you {
		if _, ok := san[k]; ok {
			shared[k] = v
		}
	}

	// Find the highest-valued shared orbit.
	max := 0
	for _, v := range shared {
		if(v > max) {
			max = v
		}
	}

	// Exploit
	total := (you["YOU"] - max) + (san["SAN"] - max)

	fmt.Println(total)
}
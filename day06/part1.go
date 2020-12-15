package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

// getDepth is called to find the depth of any body by seeking the depth of its parents recursively.
// It returns an integer representing body's depth.
func getDepth(depth map[string]int, body string, relationships [][]string) int {
	if _, ok := depth[body]; !ok {
		for _, v := range relationships{
			if(v[1] == body) {
				depth[body] = getDepth(depth, v[0], relationships) + 1
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

	depth := map[string]int{}
	total := 0
	depth["COM"] = 0
	for _, v := range relationships {
		parent, child := v[0], v[1]
		depth[child] = getDepth(depth, parent, relationships) + 1
		total += depth[child]
	}
	fmt.Println(total)
}
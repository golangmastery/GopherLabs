package main

import (
	"fmt"

	"github.com/sangam14/GopherLabs/Beginners/workshop/scope/01_package-scope/02_visibility/vis"
)

func main() {
	fmt.Println(vis.MyName)
	vis.PrintVar()
}

#  Cobra


Cobra is both a library for creating powerful modern CLI applications as well as a program to generate applications and command files.

# Installing 

Using Cobra is easy. First, use go get to install the latest version of the library. This command will install the cobra generator executable along with the library and its dependencies:

```
go get -u github.com/spf13/cobra/cobra
```
Next, include Cobra in your application:

```
import "github.com/spf13/cobra"

```

# Cobra Generator

Cobra provides its own program that will create your application and add any
commands you want. It's the easiest way to incorporate Cobra into your application.

In order to use the cobra command, compile it using the following command:

    go get github.com/spf13/cobra/cobra

This will create the cobra executable under your `$GOPATH/bin` directory.

### cobra init

The `cobra init [app]` command will create your initial application code
for you. It is a very powerful application that will populate your program with
the right structure so you can immediately enjoy all the benefits of Cobra. It
will also automatically apply the license you specify to your application.

Cobra init is pretty smart. You can either run it in your current application directory
or you can specify a relative path to an existing project. If the directory does not exist, it will be created for you.

Updates to the Cobra generator have now decoupled it from the GOPATH.
As such `--pkg-name` is required.

**Note:** init will no longer fail on non-empty directories.

```
mkdir -p newApp && cd newApp
cobra init --pkg-name github.com/spf13/newApp
```

or

```
cobra init --pkg-name github.com/spf13/newApp path/to/newApp
```

### cobra add

Once an application is initialized, Cobra can create additional commands for you.
Let's say you created an app and you wanted the following commands for it:

* app serve
* app config
* app config create

In your project directory (where your main.go file is) you would run the following:

```
cobra add serve
cobra add config
cobra add create -p 'configCmd'
```

*Note: Use camelCase (not snake_case/snake-case) for command names.
Otherwise, you will encounter errors.
For example, `cobra add add-user` is incorrect, but `cobra add addUser` is valid.*

Once you have run these three commands you would have an app structure similar to
the following:

```
  ▾ app/
    ▾ cmd/
        serve.go
        config.go
        create.go
      main.go
```

At this point you can run `go run main.go` and it would run your app. `go run
main.go serve`, `go run main.go config`, `go run main.go config create` along
with `go run main.go help serve`, etc. would all work.

Obviously you haven't added your own code to these yet. The commands are ready
for you to give them their tasks. Have fun!

### Configuring the cobra generator

The Cobra generator will be easier to use if you provide a simple configuration
file which will help you eliminate providing a bunch of repeated information in
flags over and over.

An example ~/.cobra.yaml file:

```yaml
author: Steve Francia <spf@spf13.com>
license: MIT
```

# Verify Installation 

$ cobra help

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.

```
Usage:
  cobra [command]

Available Commands:
  add         Add a command to a Cobra Application
  help        Help about any command
  init        Initialize a Cobra Application

Flags:
  -a, --author string    author name for copyright attribution (default "YOUR NAME")
      --config string    config file (default is $HOME/.cobra.yaml)
  -h, --help             help for cobra
  -l, --license string   name of license for the project
      --viper            use Viper for configuration (default true)

Use "cobra [command] --help" for more information about a command.

```

# first simple  Cobra CLI application 

```
package main

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"
)

func main() {
	var echoTimes int

	var cmdPrint = &cobra.Command{
		Use:   "print [string to print]",
		Short: "Print anything to the screen",
		Long: `print is for printing anything back to the screen.
  For many years people have printed back to the screen.`,
		Args: cobra.MinimumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println("Print: " + strings.Join(args, " "))
		},
	}

	var cmdEcho = &cobra.Command{
		Use:   "echo [string to echo]",
		Short: "Echo anything to the screen",
		Long: `echo is for echoing anything back.
  Echo works a lot like print, except it has a child command.`,
		Args: cobra.MinimumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println("Echo: " + strings.Join(args, " "))
		},
	}

	var cmdTimes = &cobra.Command{
		Use:   "times [string to echo]",
		Short: "Echo anything to the screen more times",
		Long: `echo things multiple times back to the user by providing
  a count and a string.`,
		Args: cobra.MinimumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			for i := 0; i < echoTimes; i++ {
				fmt.Println("Echo: " + strings.Join(args, " "))
			}
		},
	}

	cmdTimes.Flags().IntVarP(&echoTimes, "times", "t", 1, "times to echo the input")

	var rootCmd = &cobra.Command{Use: "app"}
	rootCmd.AddCommand(cmdPrint, cmdEcho)
	cmdEcho.AddCommand(cmdTimes)
	rootCmd.Execute()
}

```

# example 2 - Create Simple CLI Application with Flags 

create file structure like following 

```
.
├── cmd
│   ├── bye.go
│   ├── hello.go
│   └── root.go
├── go.mod
├── go.sum
└── main.go


```

main.go 


```
package main

import "cli/cmd"

func main() {
	cmd.Execute()
}

````

create folder Cmd 
and under cmd directory 


```
package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

// byeCmd represents the bye command
var byeCmd = &cobra.Command{
	Use:   "bye",
	Short: "says bye",
	Long:  `This subcommand says bye`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("bye called")
	},
}

func init() {
	RootCmd.AddCommand(byeCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// byeCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// byeCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}



```

hello.go 
```
package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

// helloCmd represents the hello command
var helloCmd = &cobra.Command{
	Use:   "hello",
	Short: "says hello",
	Long:  `This subcommand says hello`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("hello called")
	},
}

func init() {
	RootCmd.AddCommand(helloCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// helloCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// helloCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}

```
root.go
```
package cmd

import (
	"fmt"
	"os"

	homedir "github.com/mitchellh/go-homedir"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var cfgFile string

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:   "gopherlabs",
	Short: "An example of cobra",
	Long: `This application shows how to create modern CLI 
applications in go using Cobra CLI library`,
	// Uncomment the following line if your bare application
	// has an action associated with it:
	//	Run: func(cmd *cobra.Command, args []string) { },
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := RootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)

	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.
	RootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.cobra-gopherlabs.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	RootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
	} else {
		// Find home directory.
		home, err := homedir.Dir()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		// Search config in home directory with name ".gopherlabs" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigName(".CLI")
	}

	viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Println("Using config file:", viper.ConfigFileUsed())
	}
}





```

## init go module 

```

go mod init cli

```

go.mod
```
module cli

go 1.13

require (
	github.com/mitchellh/go-homedir v1.1.0
	github.com/spf13/cobra v1.0.0
	github.com/spf13/viper v1.7.1
)


```

## run cli application 

```

sangam:CLI sangam$ go run main.go
This application shows how to create modern CLI 
applications in go using Cobra CLI library

Usage:
  gopherlabs [command]

Available Commands:
  bye         says bye
  hello       says hello
  help        Help about any command

Flags:
      --config string   config file (default is $HOME/.cobra-gopherlabs.yaml)
  -h, --help            help for gopherlabs
  -t, --toggle          Help message for toggle

Use "gopherlabs [command] --help" for more information about a command.

```



# Go flag 


```
package main

import (
    "flag"
    "log"
)

var (
    account, password string
    debug             bool
)

func main() {
    flag.StringVar(&account, "account", account, "account to login")
    flag.StringVar(&password, "password", password, "password for account")
    flag.BoolVar(&debug, "debug", debug, "dump account and password or not")

    flag.Parse()

    if account == "" || password == "" {
        flag.PrintDefaults()
        return
    }

    if debug {
        log.Println("account:", account, "password:", password)
    }

    log.Println("end")
}



```

Description:

- 1. First set the parameter name and data type that will be passed in:
      -`flag.StringVar(&account, "account", account, "account to login")`
      - `flag.StringVar(&password, "password", password, "password for account")`
      - `flag.BoolVar(&debug, "debug", debug, "dump account and password or not")`
    - Call `flag.Parse()`processing incoming parameters
    - Verify the information is correct, otherwise you can call flag.PrintDefaults()output specification
    - When executed, the available `--or -access` parameter name, parameter value may be added before `=or` blank, eg:
     -  `-a=1`
     - `-a 1`
     - `--a=1`
     - ` -a=1`
     
- carried out:

  - go run .:
```
    -account string
            account to login
    -debug
            dump account and password or not
    -password string
            password for account
```
 - go run . -account 123 -password 321:

```
    2020/01/16 15:22:13 end
```
- go run . --account 123 --password 321 --debug:

```
    2020/01/16 15:22:44 account: 123 password: 321
    2020/01/16 15:22:44 end
```








## Formatting with the correct plurals

- When displaying messages for the user, the interaction is more pleasant if the sentences feel more human. 
The Go package golang.org/x/text, which is the extension package, contains this feature for formatting plurals 
in the correct way.

## Getting ready

- Execute go get -x golang.org/x/text to obtain the extension package in case you don't have it already.

```
sangam:golang-daily sangam$ go get -x golang.org/x/text
WORK=/var/folders/mg/_355pdvd741cz0z99ys9s66h0000gn/T/go-build380769388
mkdir -p $WORK/b001/
cat >$WORK/b001/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/sangam/go/src/golang.org/x/text
/usr/local/go/pkg/tool/darwin_amd64/compile -o $WORK/b001/_pkg_.a -trimpath "$WORK/b001=>" -p golang.org/x/text -complete -buildid Z8aQLviy4QTdfm0L5UnR/Z8aQLviy4QTdfm0L5UnR -goversion go1.13.4 -D "" -importcfg $WORK/b001/importcfg -pack -c=4 ./doc.go
/usr/local/go/pkg/tool/darwin_amd64/buildid -w $WORK/b001/_pkg_.a # internal
cp $WORK/b001/_pkg_.a /Users/sangam/Library/Caches/go-build/05/05d6df64800e241eb0cc32e8cdacdcdead37e6c5e5edfdb1b20826824e255b13-d # internal
mkdir -p /Users/sangam/go/pkg/darwin_amd64/golang.org/x/
mv $WORK/b001/_pkg_.a /Users/sangam/go/pkg/darwin_amd64/golang.org/x/text.a
rm -r $WORK/b001/
sangam:golang-daily sangam$ go get -x golang.org/x/text
WORK=/var/folders/mg/_355pdvd741cz0z99ys9s66h0000gn/T/go-build711045050
sangam:golang-daily sangam$ 
```
## Create the plurals.go file with the following content:
```
        package main

        import (
          "golang.org/x/text/feature/plural"
          "golang.org/x/text/language"
          "golang.org/x/text/message"
        )

        func main() {

          message.Set(language.English, "%d items to do",
            plural.Selectf(1, "%d", "=0", "no items to do",
              plural.One, "one item to do",
              "<100", "%[1]d items to do",
              plural.Other, "lot of items to do",
          ))

          message.Set(language.English, "The average is %.2f",
            plural.Selectf(1, "%.2f",
              "<1", "The average is zero",
              "=1", "The average is one",
              plural.Other, "The average is %[1]f ",
          ))

          prt := message.NewPrinter(language.English)
          prt.Printf("%d items to do", 0)
          prt.Println()
          prt.Printf("%d items to do", 1)
          prt.Println()
          prt.Printf("%d items to do", 10)
          prt.Println()
          prt.Printf("%d items to do", 1000)
          prt.Println()

          prt.Printf("The average is %.2f", 0.8)
          prt.Println()
          prt.Printf("The average is %.2f", 1.0)
          prt.Println()
          prt.Printf("The average is %.2f", 10.0)
          prt.Println()

        }

```
output:

```
sangam:golang-daily sangam$ go run plurals.go
no items to do
one item to do
10 items to do
lot of items to do
The average is zero
The average is one
The average is 10.000000 
sangam:golang-daily sangam$ 
```
## How it works...

- The package golang.org/x/text/message contains the function NewPrinter which accepts the language identification and creates the formatted I/O, the same as the fmt package does, but with the ability to translate messages based on gender and plural forms.

- The Set function of the message package adds the translation and plurals selection. The plural form itself is selected based on rules set via the Selectf function. The Selectf function produces the catalog.Message type with rules based on the plural.Form or selector.

- The preceding sample code uses plural.One and plural.Other forms, and =x, <x selectors. These are matched against the formatting verb %d (other verbs can also be used). The first matching case is chosen.

## There's more...

For more information about the selectors and forms, see the documentation for the (golang.org/x/text/message package).

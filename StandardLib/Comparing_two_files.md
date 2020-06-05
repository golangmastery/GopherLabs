# Comparing two files

- a hint on how to compare two files. The recipe will show you how to quickly determine whether the files are identical. The recipe will also present you with a way to find differences between the two.

## Create the comparison.go file with the following content:

```
        package main

        import (
          "bufio"
          "crypto/md5"
          "fmt"
          "io"
          "os"
        )

        var data = []struct {
          name string
          cont string
          perm os.FileMode
        }{
          {"test1.file", "Hello\nGolang is great", 0666},
          {"test2.file", "Hello\nGolang is great", 0666},
          {"test3.file", "Not matching\nGolang is great\nLast line",
           0666},
        }

        func main() {

          files := []*os.File{}
          for _, fData := range data {
            f, err := os.Create(fData.name)
            if err != nil {
              panic(err)
            }
            defer f.Close()
            _, err = io.WriteString(f, fData.cont)
            if err != nil {
              panic(err)
            }
            files = append(files, f)
          }

          // Compare by checksum
          checksums := []string{}
          for _, f := range files {
            f.Seek(0, 0) // reset to beginning of file
            sum, err := getMD5SumString(f)
            if err != nil {
              panic(err)
            }
            checksums = append(checksums, sum)
          }

          fmt.Println("### Comparing by checksum ###")
          compareCheckSum(checksums[0], checksums[1])
          compareCheckSum(checksums[0], checksums[2])

          fmt.Println("### Comparing line by line ###")
          files[0].Seek(0, 0)
          files[2].Seek(0, 0)
          compareFileByLine(files[0], files[2])

          // Cleanup
          for _, val := range data {
            os.Remove(val.name)
          }

        }

        func getMD5SumString(f *os.File) (string, error) {
          file1Sum := md5.New()
          _, err := io.Copy(file1Sum, f)
          if err != nil {
            return "", err
          }
          return fmt.Sprintf("%X", file1Sum.Sum(nil)), nil
        }

        func compareCheckSum(sum1, sum2 string) {
          match := "match"
          if sum1 != sum2 {
            match = " does not match"
          }
          fmt.Printf("Sum: %s and Sum: %s %s\n", sum1, sum2, match)
        }

        func compareLines(line1, line2 string) {
          sign := "o"
          if line1 != line2 {
            sign = "x"
          }
          fmt.Printf("%s | %s | %s \n", sign, line1, line2)
        }

        func compareFileByLine(f1, f2 *os.File) {
          sc1 := bufio.NewScanner(f1)
          sc2 := bufio.NewScanner(f2)

          for {
            sc1Bool := sc1.Scan()
            sc2Bool := sc2.Scan()
            if !sc1Bool && !sc2Bool {
              break
            }
            compareLines(sc1.Text(), sc2.Text())
          }
        }


```
output:
```

sangam:golang-daily sangam$ go run comparison.go
### Comparing by checksum ###
Sum: 5A07C1538087CD5B5C365DE52970E0A3 and Sum: 5A07C1538087CD5B5C365DE52970E0A3 match
Sum: 5A07C1538087CD5B5C365DE52970E0A3 and Sum: FED2EADA5D1D1EBF745DFDC7D1385E6C  does not match
### Comparing line by line ###
x | Hello | Not matching 
o | Golang is great | Golang is great 
x |  | Last line 
sangam:golang-daily sangam$

```
## How it works...

- The comparison of the two files can be done in a few ways. This recipe describes the two basic ones.
The first one is by doing a comparison of the whole file by creating the checksum of the file.

- The Generating checksum recipe of (https://collabnix.github.io/gopherlabs/Beginners/Generating_checksums.html) Dealing with Numbers shows how you can create the checksum of the file. This way, the getMD5SumString function generates the checksum string, which is a hexadecimal representation of the byte result of MD5. The strings are then compared.

- The second approach compares the files line by line (in this case, the string content). 
- In case the lines are not matching, the x sign is included. This is the same way you can compare the binary content,
but you will need to scan the file by blocks of bytes (byte slices).

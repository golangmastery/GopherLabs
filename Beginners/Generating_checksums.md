## Generating checksums

- The hash, or so-called checksum, is the easiest way to quickly compare any content. This recipe demonstrates how to create the checksum of the file content. For demonstration purposes,
the MD5 hash function will be used.

## Create the content.dat file with the following content:
```
    This is content to check
```
Create the checksum.go file with the following content:

```
        package main

        import (
          "crypto/md5"
          "fmt"
          "io"
          "os"
        )

        var content = "This is content to check"

        func main() {

          checksum := MD5(content)
          checksum2 := FileMD5("content.dat")

          fmt.Printf("Checksum 1: %s\n", checksum)
          fmt.Printf("Checksum 2: %s\n", checksum2)
          if checksum == checksum2 {
            fmt.Println("Content matches!!!")
          }

        }

        // MD5 creates the md5
        // hash for given content encoded in
        // hex string
        func MD5(data string) string {
          h := md5.Sum([]byte(data))
          return fmt.Sprintf("%x", h)
        }

        // FileMD5 creates hex encoded md5 hash
        // of file content
        func FileMD5(path string) string {
          h := md5.New()
          f, err := os.Open(path)
          if err != nil {
            panic(err)
          }
          defer f.Close()
          _, err = io.Copy(h, f)
          if err != nil {
            panic(err)
          }
          return fmt.Sprintf("%x", h.Sum(nil))
        }


```
output:
```
sangam:golang-daily sangam$ go run checksum.go
Checksum 1: e44f5ac2d500bde35ace3dcc34cc6bf1
Checksum 2: 958ba356a2c98156d367a14b86226a1c
sangam:golang-daily sangam$ 
```
## How it works...

- The crypto package contains implementations of well-known hash functions. The MD5 hash function is located in the crypto/md5 package. Each hash function in the crypto package implements the Hash interface.  Note that Hash contains the Write  method. With the Write method, it can be utilized as a Writer. This can be seen in the FileMD5 function. 
The Sum method of Hash accepts the argument of byte slice, where the resulting hash should be placed.
- Beware of this. The Sum method does not compute the hash of the argument, but computes the hash into an argument
- On the other hand, md5.Sum, the package function, can be used to produce the hash directly. In this case, the argument of the Sum function is the one from the hash values computed.
- Naturally, the crypto package implements the SHA variants and other hash functions as well. These are usually used in the same way. The hash functions can be accessed through the crypto package constant crypto.Hash (for example, crypto.MD5.New()), but this way, the package with the given function must be linked to a built binary as well (the blank import could be used, import _ "crypto/md5"),
otherwise the call for New will panic.
- The hash package itself contains the CRC checksums and more.

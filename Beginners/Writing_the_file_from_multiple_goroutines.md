## Writing the file from multiple goroutines

 - how to safely write to the file from multiple goroutines.

Create the syncwrite.go file with the following content:
```
        package main

        import (
          "fmt"
          "io"
          "os"
          "sync"
        )

        type SyncWriter struct {
          m sync.Mutex
          Writer io.Writer
        }

        func (w *SyncWriter) Write(b []byte) (n int, err error) {
          w.m.Lock()
          defer w.m.Unlock()
          return w.Writer.Write(b)
        }

        var data = []string{
          "Hello!",
          "Ola!",
          "Ahoj!",
        }

        func main() {

          f, err := os.Create("sample.file")
          if err != nil {
            panic(err)
          }

          wr := &SyncWriter{sync.Mutex{}, f}
          wg := sync.WaitGroup{}
          for _, val := range data {
            wg.Add(1)
            go func(greetings string) {
              fmt.Fprintln(wr, greetings)
              wg.Done()
            }(val)
          }

          wg.Wait()
        }


```

```
sangam:golang-daily sangam$ go run syncwrite.go
sangam:golang-daily sangam$ cat sample.file 
Ahoj!
Hello!
Ola!
sangam:golang-daily sangam$ 

```

## How it works...

- Writing concurrently to a file is a problem that can end up with inconsistent file content. It is better to synchronize the writing to the file by using Mutex or any other synchronization primitive. This way, you ensure that only one goroutine at a time will be able to write to the file. 

- The preceding code creates a Writer with Mutex, which embeds the Writer (os.File, in this case), and for each Write call, internally locks the Mutex to provide exclusivity. After the write operation is complete, the Mutex primitive is unlocked naturally.

# Serializing objects to binary format

- Besides the well-known JSON and XML, Go also offers the binary format, gob. 
This recipe goes through the basic concept of how to use the gob package.

## Create the gob.go file with the following content:
```
package main

import (
	"bytes"
	"encoding/gob"
	"fmt"
)

type User struct {
	FirstName string
	LastName  string
	Age       int
	Active    bool
}

func (u User) String() string {
	return fmt.Sprintf(`{"FirstName":%s,"LastName":%s,
											 "Age":%d,"Active":%v }`,
		u.FirstName, u.LastName, u.Age, u.Active)
}

type SimpleUser struct {
	FirstName string
	LastName  string
}

func (u SimpleUser) String() string {
	return fmt.Sprintf(`{"FirstName":%s,"LastName":%s}`,
		u.FirstName, u.LastName)
}

func main() {

	var buff bytes.Buffer

	// Encode value
	enc := gob.NewEncoder(&buff)
	user := User{
		"sangam",
		"biradar",
		24,
		true,
	}
	enc.Encode(user)
	fmt.Printf("%X\n", buff.Bytes())

	// Decode value
	out := User{}
	dec := gob.NewDecoder(&buff)
	dec.Decode(&out)
	fmt.Println(out.String())

	enc.Encode(user)
	out2 := SimpleUser{}
	dec.Decode(&out2)
	fmt.Println(out2.String())

}


```
output:

```
sangam:golang-daily sangam$ go run gob.go
40FF81030101045573657201FF82000104010946697273744E616D65010C0001084C6173744E616D65010C0001034167650104000106416374697665010200000018FF82010673616E67616D0107626972616461720130010100
{"FirstName":sangam,"LastName":biradar,
										 "Age":24,"Active":true }
{"FirstName":sangam,"LastName":biradar}
sangam:golang-daily sangam$ 


```

## How it works...

- The gob serialization and deserialization need the Encoder and Decoder.
The gob.NewEncoder function creates the Encoder with the underlying Writer. 
- Each call of the Encode method will serialize the object into a gob format. 
The gob format itself is the self-describing binary format. This means each serialized struct is preceded by its description.

- To decode the data from the serialized form, the Decoder must be created by calling the gob.NewDecoder with the underlying Reader. The Decode then accepts the pointer to the structure where the data should be deserialized. 

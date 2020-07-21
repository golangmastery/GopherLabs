# Scalar Value Types

A scalar message field can have one of the following types – the table shows the type specified in the .proto file, and the corresponding type in the automatically generated class:


| .proto Type 	| Notes 	| C++ Type 	| Java Type 	| Python Type<br>[2] 	| Go Type 	| Ruby Type 	| C# Type 	| PHP Type 	| Dart Type 	|
|-	|-	|-	|-	|-	|-	|-	|-	|-	|-	|
| double 	|  	| double 	| double 	| float 	| float64 	| Float 	| double 	| float 	| double 	|
| float 	|  	| float 	| float 	| float 	| float32 	| Float 	| float 	| float 	| double 	|
| int32 	| Uses variable-length encoding. Inefficient for encoding negative numbers<br> – if your field is likely to have negative values, use sint32 instead. 	| int32 	| int 	| int 	| int32 	| Fixnum or Bignum (as required) 	| int 	| integer 	| int 	|
| int64 	| Uses variable-length encoding. Inefficient for encoding negative numbers<br> – if your field is likely to have negative values, use sint64 instead. 	| int64 	| long 	| int/long<br>[3] 	| int64 	| Bignum 	| long 	| integer/string<br>[5] 	| Int64 	|
| uint32 	| Uses variable-length encoding. 	| uint32 	| int<br>[1] 	| int/long<br>[3] 	| uint32 	| Fixnum or Bignum (as required) 	| uint 	| integer 	| int 	|
| uint64 	| Uses variable-length encoding. 	| uint64 	| long<br>[1] 	| int/long<br>[3] 	| uint64 	| Bignum 	| ulong 	| integer/string<br>[5] 	| Int64 	|
| sint32 	| Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. 	| int32 	| int 	| int 	| int32 	| Fixnum or Bignum (as required) 	| int 	| integer 	| int 	|
| sint64 	| Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. 	| int64 	| long 	| int/long<br>[3] 	| int64 	| Bignum 	| long 	| integer/string<br>[5] 	| Int64 	|
| fixed32 	| Always four bytes. More efficient than uint32 if values are often greater than 2^28 	| uint32 	| int<br>[1] 	| int/long<br>[3] 	| uint32 	| Fixnum or Bignum (as required) 	| uint 	| integer 	| int 	|
| fixed64 	| Always eight bytes. More efficient than uint64 if values are often greater than 2^56 	| uint64 	| long<br>[1] 	| int/long<br>[3] 	| uint64 	| Bignum 	| ulong 	| integer/string<br>[5] 	| Int64 	|
| sfixed32 	| Always four bytes. 	| int32 	| int 	| int 	| int32 	| Fixnum or Bignum (as required) 	| int 	| integer 	| int 	|
| sfixed64 	| Always eight bytes. 	| int64 	| long 	| int/long<br>[3] 	| int64 	| Bignum 	| long 	| integer/string<br>[5] 	| Int64 	|
| bool 	|  	| bool 	| boolean 	| bool 	| bool 	| TrueClass/FalseClass 	| bool 	| boolean 	| bool 	|
| string 	| A string must always contain UTF-8 encoded or 7-bit ASCII text, and cannot be longer than 2^32. 	| string 	| String 	| str/unicode<br>[4] 	| string 	| String (UTF-8) 	| string 	| string 	| String 	|
| bytes 	| May contain any arbitrary sequence of bytes no longer than 2^32. 	| string 	| ByteString 	| str 	| []byte 	| String (ASCII-8BIT) 	| ByteString 	| string 	| List 	|


All types are encoded with a variable size depending on the magnitude of the value. Fixed types have fixed sizes (4 or 8 bytes).

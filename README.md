# unzip-luau
Fast Luau module for decoding zip files

# API

## `Unzip(Data: buffer) -> { [string]: buffer }`
Decodes a zip file and returns files in this format: `[foldername/filename] = buffer`

# Example usage

```luau
const Unzip = require(path.to.unzip)

const ZipFile = buffer.fromstring(game:GetService("HttpService"):GetAsync("https://getsamplefiles.com/download/zip/sample-1.zip"))

const Data = Unzip(ZipFile)
print(Data)
```

Output:
```
{
  ["__MACOSX/sample-1/._sample-1.webp"] = buffer { Size = 406 },
  ["__MACOSX/sample-1/._sample-1_1.webp"] = buffer { Size = 279 },
  ["__MACOSX/sample-1/._sample-5 (1).jpg"] = buffer { Size = 403 },
  ["__MACOSX/sample-1/._sample-5.webp"] = buffer { Size = 406 },
  ["sample-1/"] = buffer { Size = 0 },
  ["sample-1/sample-1.webp"] = buffer { Size = 361666 },
  ["sample-1/sample-1_1.webp"] = buffer { Size = 361666 },
  ["sample-1/sample-5 (1).jpg"] = buffer { Size = 214895 },
  ["sample-1/sample-5.webp"] = buffer { Size = 159068 }
}
```

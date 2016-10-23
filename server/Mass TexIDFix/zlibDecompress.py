import zlib
import sys

with open(sys.argv[1],'rb') as f:
    contents = f.read()
    f.seek(0)

with open(sys.argv[1],'wb') as f:
    f.write(zlib.decompress(contents))

print 'File decompressed'

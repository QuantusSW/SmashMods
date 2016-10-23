import zlib
import sys
import os

with open(sys.argv[1],'rb') as f:
    content = f.read()
    libbed = False
    try:
        zlib.decompress(content)
        print "zlibbed"
        libbed = True
    except:
        print "Not zlibbed"
if libbed:
    sys.exit(1)

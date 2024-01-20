import os, sys
from PIL import Image
# Make sure original image ('test.png') is in root directory
images = ['test.png']
for infile in images:
    f, e = os.path.splitext(infile)
    outfile = f + '.jpg'
    if infile != outfile:
        try:
            with Image.open(infile) as image:
                in_rgb = image.convert('RGB')
                in_rgb.save(outfile, 'JPEG')
        except OSError:
            print('Conversion failed for', infile)

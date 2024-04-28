import cv2
import numpy as np

haystack = "haystack.png"
needle = "needle/druid/ability_druid_mangle2.png"

haystack_image = cv2.imread(haystack, cv2.IMREAD_UNCHANGED)
needle_image = cv2.imread(needle, cv2.IMREAD_UNCHANGED)

# Get the dimensions of both images
haystack_height, haystack_width = haystack_image.shape[:2]
needle_height, needle_width = needle_image.shape[:2]

# Resize the images to match the height of the tallest one and adjust the width accordingly
if haystack_height > needle_height:
    scale_factor = haystack_height / needle_height
    new_width = int(needle_width * scale_factor)
    needle_image_resized = cv2.resize(needle_image, (new_width, haystack_height))
    haystack_resized = haystack_image
else:
    scale_factor = needle_height / haystack_height
    new_width = int(haystack_width * scale_factor)
    haystack_resized = cv2.resize(haystack_image, (new_width, needle_height))
    needle_image_resized = needle_image

# Save resized images
cv2.imwrite("resized_haystack.png", haystack_resized)
cv2.imwrite("resized_needle.png", needle_image_resized)

result = cv2.matchTemplate(haystack_resized, needle_image_resized, cv2.TM_CCOEFF_NORMED)


from PIL import Image
import imagehash

hash0 = imagehash.average_hash(Image.open(haystack))
hash1 = imagehash.average_hash(Image.open(needle))
cutoff = 5  # maximum bits that could be different between the hashes.

if hash0 - hash1 < cutoff:
    print("images are similar")
else:
    print("images are not similar")


cv2.imshow("Result", result)
cv2.waitKey()

import cv2
import os

# Load the main image (2.png)
main_image = cv2.imread("1.jpg", cv2.IMREAD_GRAYSCALE)


# Function to find 1.jpg in another image and return confidence level
def find_image_in_template(template_path, main_image):
    # Load the template image
    template = cv2.imread(template_path, cv2.IMREAD_GRAYSCALE)

    # Match the template in the main image
    result = cv2.matchTemplate(main_image, template, cv2.TM_CCOEFF_NORMED)
    min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

    # Calculate the confidence level
    confidence_level = max_val

    return confidence_level


# Iterate through images in the folder
images_folder = "images"
for filename in os.listdir(images_folder):
    image_path = os.path.join(images_folder, filename)
    confidence = find_image_in_template(image_path, main_image)
    print(f"{filename}: {confidence*100}% confident")

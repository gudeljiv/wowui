import cv2
import numpy as np
import os

# Define the path to the directory containing the script
dir_path = os.path.dirname(os.path.realpath(__file__))
abilities_folder = dir_path + "/needle/druid/"

# Load the original haystack image
original_haystack_img = cv2.imread(dir_path + "/haystack.png", 0)  # Load the haystack image in grayscale

# Path to the folder containing needle images
needle_folder_path = abilities_folder

# Iterate through all files in the needle folder
for filename in os.listdir(needle_folder_path):
    if filename.endswith(".jpg"):
        # Load the current needle image
        needle_img = cv2.imread(os.path.join(needle_folder_path, filename), 0)

        # Define the scales to progressively enlarge the haystack image
        scales = np.arange(0.5, 5.1, 0.1)  # From 0.5 to 5.0 with 0.1 increment

        # Iterate through different scales of the haystack image
        for scale in scales:
            try:
                # Resize the haystack image according to the current scale
                resized_haystack_img = cv2.resize(original_haystack_img, None, fx=scale, fy=scale)

                # Use template matching to find the needle in the resized haystack
                result = cv2.matchTemplate(resized_haystack_img, needle_img, cv2.TM_CCOEFF_NORMED)

                # Define a threshold to determine a match
                threshold = 0.8  # You can adjust this threshold as needed

                # Get the locations where the needle matches the resized haystack above the threshold
                locations = np.where(result >= threshold)
                if len(locations[0]) > 0:
                    print(f"Needle '{filename}' FOUND in haystack at scale {scale}!")
                    # You can then use the 'locations' variable to get the coordinates of the matches
                    break  # If found, no need to search in further scales
                else:
                    # print(f"Needle '{filename}' not found in haystack at scale {scale}.")
                    continue
            except Exception as e:
                # print(f"An error occurred: {e}. Continuing to the next scale.")
                continue

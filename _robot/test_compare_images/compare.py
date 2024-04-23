import cv2
import os
import numpy as np


def resize_and_save(image_path, output_folder, new_width, new_height):
    # Load image
    image = cv2.imread(image_path)

    # Resize image
    resized_image = cv2.resize(image, (new_width, new_height))

    # Create output folder if it doesn't exist
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Extract filename from the image path
    filename = os.path.basename(image_path)

    # Save resized image
    output_path = os.path.join(output_folder, filename)
    cv2.imwrite(output_path, resized_image)
    print(f"Resized image saved to {output_path}")


def calculate_difference(image1, image2):
    # Calculate absolute difference for each channel
    diff_blue = cv2.absdiff(image1[:, :, 0], image2[:, :, 0])
    diff_green = cv2.absdiff(image1[:, :, 1], image2[:, :, 1])
    diff_red = cv2.absdiff(image1[:, :, 2], image2[:, :, 2])

    # Combine channel differences
    diff_combined = cv2.merge((diff_blue, diff_green, diff_red))

    # Calculate total number of different pixels
    total_pixels = np.prod(diff_combined.shape[:2])
    different_pixels = np.sum(diff_combined > 0)

    # Calculate confidence percent
    confidence_percent = (1 - (different_pixels / total_pixels)) * 100

    return confidence_percent


def compare_images(image1_path, image2_path):
    # Load images
    image1 = cv2.imread(image1_path)
    image2 = cv2.imread(image2_path)

    # Resize images to have the same dimensions
    height, width = min(image1.shape[0], image2.shape[0]), min(image1.shape[1], image2.shape[1])
    image1_resized = cv2.resize(image1, (width, height))
    image2_resized = cv2.resize(image2, (width, height))

    # Save resized images
    output_folder = "_robot/test_compare_images/_resized"
    resize_and_save(image1_path, output_folder, width, height)
    resize_and_save(image2_path, output_folder, width, height)

    # Calculate confidence percent
    confidence_percent = calculate_difference(image1_resized, image2_resized)

    # Print confidence percent
    print(f"Confidence percent: {confidence_percent:.2f}%")


# Paths to the images to compare
image1_path = "_robot/test_compare_images/1.jpg"
image2_path = "_robot/test_compare_images/2.png"

# Compare the two images
compare_images(image1_path, image2_path)

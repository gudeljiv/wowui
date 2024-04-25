import cv2


def compare_images(img_path1, img_path2, method=cv2.TM_CCOEFF):
    img1 = cv2.imread(img_path1)
    img2 = cv2.imread(img_path2)
    img1 = cv2.cvtColor(img1, cv2.COLOR_BGR2RGB)  ### convert color bgr to rgb
    img2 = cv2.cvtColor(img2, cv2.COLOR_BGR2RGB)

    resized_image2 = cv2.resize(img2, (img1.shape[1], img1.shape[0]))
    cv2.imwrite("_robot/test_compare_images/resized_image2.jpg", resized_image2)

    height, width, channels = resized_image2.shape

    bg_copy = img1.copy()
    result = cv2.matchTemplate(bg_copy, resized_image2, method)
    # Get the min and max values and their locations
    min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

    if method in [cv2.TM_SQDIFF, cv2.TM_SQDIFF_NORMED]:
        match_val = 1.0 - min_val
    else:
        match_val = max_val

    # Calculate match percentage
    match_percent = (match_val / (width * height)) * 100

    # Scale match percent to a range from 1 to 100
    match_percent = max(min(match_percent, 100), 1)

    return match_percent


# Example usage:
match_percent = compare_images("1.jpg", "3.png", method=cv2.TM_CCOEFF)
print("Match Percentage:", match_percent)

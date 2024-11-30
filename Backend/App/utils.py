# app/utils.py

import numpy as np
import cv2

def preprocess_image(image, target_size):
    """
    Preprocess the input image for the model.
    """
    image = cv2.resize(image, target_size)
    image = image.astype(np.float32) / 255.0
    return image

def decode_base64_and_preprocess(base64_str, target_size):
    """
    Decode a base64 string and preprocess the image.
    """
    img_data = base64.b64decode(base64_str)
    np_arr = np.frombuffer(img_data, np.uint8)
    image = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
    return preprocess_image(image, target_size)

def encode_image_to_base64(image):
    """
    Encode an image to a base64 string.
    """
    _, buffer = cv2.imencode('.jpg', image)
    return base64.b64encode(buffer).decode('utf-8')
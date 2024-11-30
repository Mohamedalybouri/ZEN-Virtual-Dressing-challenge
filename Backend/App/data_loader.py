# app/data_loader.py

import os
import numpy as np
import cv2
import tensorflow as tf

class VirtualTryOnDataLoader:
    def __init__(self, config):
        self.config = config

    def load_data(self, person_dir, cloth_dir):
        """
        Load and preprocess images from the specified directories.
        """
        person_images = []
        cloth_images = []

        for person_file in os.listdir(person_dir):
            if person_file.endswith(('.png', '.jpg', '.jpeg')):
                person_img = cv2.imread(os.path.join(person_dir, person_file))
                person_img = cv2.resize(person_img, self.config.IMAGE_SIZE)
                person_images.append(person_img)

        for cloth_file in os.listdir(cloth_dir):
            if cloth_file.endswith(('.png', '.jpg', '.jpeg')):
                cloth_img = cv2.imread(os.path.join(cloth_dir, cloth_file))
                cloth_img = cv2.resize(cloth_img, self.config.IMAGE_SIZE)
                cloth_images.append(cloth_img)

        # Normalize images
        person_images = np.array(person_images, dtype=np.float32) / 255.0
        cloth_images = np.array(cloth_images, dtype=np.float32) / 255.0

        return person_images, cloth_images

    def create_dataset(self, person_images, cloth_images, batch_size):
        """
        Create a TensorFlow dataset from the images.
        """
        dataset = tf.data.Dataset.from_tensor_slices((person_images, cloth_images))
        dataset = dataset.shuffle(buffer_size=len(person_images))
        dataset = dataset.batch(batch_size)
        dataset = dataset.prefetch(tf.data.experimental.AUTOTUNE)

        return dataset
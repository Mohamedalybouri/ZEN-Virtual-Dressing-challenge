import os
import numpy as np
import cv2
import tensorflow as tf

class VirtualTryOnDataLoader:
    def __init__(self, config):
        """
        Initialize the data loader with the given configuration.
        Args:
            config: A configuration object containing parameters like IMAGE_SIZE and directories.
        """
        self.config = config
        self.image_size = config.IMAGE_SIZE  # Desired image size for resizing

    def _preprocess_image(self, image_path):
        """
        Preprocess an image by reading, resizing, normalizing, and converting its color space.
        Args:
            image_path: Path to the image file.
        Returns:
            Preprocessed image as a NumPy array.
        """
        image = cv2.imread(image_path)  # Read the image from the specified path
        image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)  # Convert BGR (OpenCV default) to RGB
        image = cv2.resize(image, self.image_size)  # Resize the image to the desired size
        image = image.astype(np.float32) / 255.0  # Normalize pixel values to [0, 1]
        return image

    def load_dataset(self):
        """
        Load and preprocess the dataset based on training pairs.
        Returns:
            Tuple of NumPy arrays: persons, clothes, cloth_masks, openpose_imgs, and targets.
        """
        # Initialize empty lists for storing data
        persons = []
        clothes = []
        targets = []
        cloth_masks = []
        openpose_imgs = []
        openpose_jsons = []

        # Path to the file containing training pairs information
        pairs_file = os.path.join(self.config.TRAIN_DIR, 'train_pairs.txt')
        
        # Read and parse the training pairs file
        with open(pairs_file, 'r') as f:
            pairs = [line.strip().split() for line in f.readlines()]

        for pair in pairs:
            # Construct full paths for all input files based on training directory and pair information
            person_path = os.path.join(self.config.TRAIN_DIR, 'image', pair[0])
            cloth_path = os.path.join(self.config.TRAIN_DIR, 'cloth', pair[1])
            cloth_mask_path = os.path.join(self.config.TRAIN_DIR, 'cloth-mask', pair[2])  # Cloth mask path
            openpose_img_path = os.path.join(self.config.TRAIN_DIR, 'openpose_img', pair[3])  # OpenPose image path
            openpose_json_path = os.path.join(self.config.TRAIN_DIR, 'openpose_json', pair[4])  # OpenPose JSON path

            # Skip the current pair if any file doesn't exist
            if not (os.path.exists(person_path) and os.path.exists(cloth_path) and 
                    os.path.exists(cloth_mask_path) and os.path.exists(openpose_img_path) and 
                    os.path.exists(openpose_json_path)):
                continue

            # Preprocess each image
            person_img = self._preprocess_image(person_path)
            cloth_img = self._preprocess_image(cloth_path)
            cloth_mask = self._preprocess_image(cloth_mask_path)
            openpose_img = self._preprocess_image(openpose_img_path)

            # Append preprocessed data to respective lists
            persons.append(person_img)
            clothes.append(cloth_img)
            cloth_masks.append(cloth_mask)
            openpose_imgs.append(openpose_img)  # OpenPose image preprocessing can be modified as needed
            targets.append(cloth_path)  # Target may be modified as per specific requirements

        # Convert lists to NumPy arrays for further processing
        return (
            np.array(persons), 
            np.array(clothes), 
            np.array(cloth_masks), 
            np.array(openpose_imgs),
            np.array(targets)
        )

    def create_tf_dataset(self):
        """
        Create a TensorFlow dataset from the loaded dataset.
        Returns:
            A tf.data.Dataset object for training or evaluation.
        """
        # Load preprocessed data
        persons, clothes, cloth_masks, openpose_imgs, targets = self.load_dataset()

        # Create a TensorFlow dataset from the loaded data
        dataset = tf.data.Dataset.from_tensor_slices(({
            'person_image': persons, 
            'cloth_image': clothes,
            'cloth_mask': cloth_masks,
            'openpose_image': openpose_imgs
        }, targets))
        
        # Shuffle, batch, and prefetch data for optimized performance
        dataset = dataset.shuffle(buffer_size=len(persons))  # Shuffle with buffer size equal to dataset size
        dataset = dataset.batch(self.config.BATCH_SIZE)  # Group data into batches
        dataset = dataset.prefetch(tf.data.AUTOTUNE)  # Prefetch data for efficiency during training
        
        return dataset

import os

class Config:
    # Dataset Configuration
    DATA_DIR = os.path.join(os.getcwd(), '/content/virtual-tryon-dataset/Virtual tryon data')
    TRAIN_DIR = os.path.join(DATA_DIR, 'train')
    TEST_DIR = os.path.join(DATA_DIR, 'test')
    
    # Model Hyperparameters
    IMAGE_SIZE = (256, 256)
    BATCH_SIZE = 4
    CHUNK_SIZE = 1000  # Number of samples to process in each chunk
    EPOCHS = 50
    LEARNING_RATE = 1e-4
    
    # Paths
    MODEL_SAVE_PATH = os.path.join(os.getcwd(), '/content/saved_models')
    
    # GPU Configuration
    USE_MIXED_PRECISION = True
    
    # Logging
    LOGGING_DIR = os.path.join(os.getcwd(), 'logs')

    def __init__(self):
        # Create necessary directories
        os.makedirs(self.MODEL_SAVE_PATH, exist_ok=True)
        os.makedirs(self.LOGGING_DIR, exist_ok=True)
import os
import tensorflow as tf
from conf_file import Config
from App.data_loader import VirtualTryOnDataLoader
from App.models import VirtualTryOnModel

def train_virtual_tryon():
    # Configuration
    config = Config()

    # Create data loader
    data_loader = VirtualTryOnDataLoader(config)

    # Create dataset with memory optimization
    dataset = data_loader.create_tf_dataset()

    # Split dataset
    dataset_size = len(dataset)
    train_size = int(0.8 * dataset_size)
    train_dataset = dataset.take(train_size)
    val_dataset = dataset.skip(train_size)

    # Enable memory growth and limit
    gpus = tf.config.experimental.list_physical_devices('GPU')
    if gpus:
        try:
            tf.config.experimental.set_memory_growth(gpus[0], True)
        except RuntimeError as e:
            print(f"Memory growth setting error: {e}")

    # Create model with memory-efficient strategy
    with tf.keras.utils.custom_object_scope({}):  # Add custom objects if needed
        virtual_tryon_model = VirtualTryOnModel(config)

    # Print model summary
    virtual_tryon_model.model.summary()

    # Train model with memory-efficient approach
    history = virtual_tryon_model.train(
        train_dataset, 
        val_dataset
    )

    # Save final model
    virtual_tryon_model.model.save(
        os.path.join(config.MODEL_SAVE_PATH, 'final_model.h5'),
        save_format='h5'
    )

    return history

def main():
    try:
        # Train the model
        training_history = train_virtual_tryon()
        
        # Optional: Plot training history if matplotlib is available
        try:
            import matplotlib.pyplot as plt
            
            plt.figure(figsize=(10, 4))
            plt.subplot(1, 2, 1)
            plt.plot(training_history.history['loss'], label='Training Loss')
            plt.plot(training_history.history['val_loss'], label='Validation Loss')
            plt.title('Model Loss')
            plt.xlabel('Epoch')
            plt.ylabel('Loss')
            plt.legend()

            plt.subplot(1, 2, 2)
            plt.plot(training_history.history['accuracy'], label='Training Accuracy')
            plt.plot(training_history.history['val_accuracy'], label='Validation Accuracy')
            plt.title('Model Accuracy')
            plt.xlabel('Epoch')
            plt.ylabel('Accuracy')
            plt.legend()

            plt.tight_layout()
            plt.savefig(os.path.join(config.MODEL_SAVE_PATH, 'training_history.png'))
            print("Training history plot saved.")
        except ImportError:
            print("Matplotlib not available for plotting.")

    except Exception as e:
        print(f"Training failed: {e}")

if __name__ == '__main__':
    main()
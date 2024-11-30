import os
import tensorflow as tf
from tensorflow.keras import layers, Model, optimizers

class VirtualTryOnModel:
    def __init__(self, config):
        self.config = config
        self.model = self._build_model()

    def _build_model(self):
        """
        Lightweight and memory-efficient virtual try-on model
        """
        # Inputs
        person_input = layers.Input(
            shape=(*self.config.IMAGE_SIZE, 3), 
            name='person_image'
        )
        cloth_input = layers.Input(
            shape=(*self.config.IMAGE_SIZE, 3), 
            name='cloth_image'
        )
        cloth_mask_input = layers.Input(
            shape=(*self.config.IMAGE_SIZE, 3), 
            name='cloth_mask'
        )
        openpose_input = layers.Input(
            shape=(*self.config.IMAGE_SIZE, 3), 
            name='openpose_image'
        )

        # Shared lightweight encoder
        def lightweight_encoder(inputs, filters=64):
            x = layers.Conv2D(filters, 3, padding='same', activation='relu')(inputs)
            x = layers.BatchNormalization()(x)
            x = layers.MaxPooling2D()(x)
            x = layers.Conv2D(filters*2, 3, padding='same', activation='relu')(x)
            x = layers.BatchNormalization()(x)
            x = layers.MaxPooling2D()(x)
            return x

        # Combine inputs
        combined_input = layers.Concatenate()([
            person_input, 
            cloth_input, 
            cloth_mask_input, 
            openpose_input
        ])

        # Feature extraction
        x = lightweight_encoder(combined_input)
        
        # Decoder with skip connections
        x = layers.UpSampling2D()(x)
        x = layers.Conv2D(128, 3, padding='same', activation='relu')(x)
        x = layers.BatchNormalization()(x)
        
        x = layers.UpSampling2D()(x)
        x = layers.Conv2D(64, 3, padding='same', activation='relu')(x)
        x = layers.BatchNormalization()(x)

        # Final output layer
        output = layers.Conv2D(3, 3, activation='sigmoid', padding='same')(x)

        # Create model
        model = Model(
            inputs=[person_input, cloth_input, cloth_mask_input, openpose_input], 
            outputs=output
        )

        # Compile with Adam optimizer and lightweight loss
        optimizer = optimizers.Adam(
            learning_rate=self.config.LEARNING_RATE
        )

        model.compile(
            optimizer=optimizer,
            loss='binary_crossentropy',  # More memory-efficient loss
            metrics=['accuracy']
        )

        return model

    def train(self, train_dataset, val_dataset):
        """
        Memory-efficient training
        """
        # Create save directory
        os.makedirs(self.config.MODEL_SAVE_PATH, exist_ok=True)

        # Memory-efficient callbacks
        callbacks = [
            tf.keras.callbacks.ModelCheckpoint(
                filepath=os.path.join(self.config.MODEL_SAVE_PATH, 'best_model.h5'),
                save_best_only=True,
                monitor='val_loss'
            ),
            tf.keras.callbacks.ReduceLROnPlateau(
                monitor='val_loss',
                factor=0.5,
                patience=3,
                min_lr=1e-5
            ),
            tf.keras.callbacks.EarlyStopping(
                monitor='val_loss',
                patience=7,
                restore_best_weights=True
            )
        ]

        # Memory-efficient training
        history = self.model.fit(
            train_dataset,
            validation_data=val_dataset,
            epochs=self.config.EPOCHS,
            callbacks=callbacks,
            verbose=1
        )

        return history
# app/models.py

import tensorflow as tf
from tensorflow.keras import layers, Model
import tensorflow_addons as tfa

class VirtualTryOnModel:
    def __init__(self, config):
        self.config = config
        self.model = self._build_model()

    def _build_model(self):
        """
        Advanced multi-input virtual try-on model
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

        # Shared Encoder with multiple conv layers
        def create_encoder():
            return tf.keras.Sequential([
                layers.Conv2D(64, 3, activation='relu', padding='same'),
                layers.BatchNormalization(),
                layers.MaxPooling2D(),
                layers.Conv2D(128, 3, activation='relu', padding='same'),
                layers.BatchNormalization(),
                layers.MaxPooling2D(),
                layers.Conv2D(256, 3, activation='relu', padding='same'),
                layers.BatchNormalization(),
                layers.Flatten()
            ])

        # Shared encoder
        encoder = create_encoder()

        # Extract features
        person_features = encoder(person_input)
        cloth_features = encoder(cloth_input)

        # Feature fusion
        combined_features = layers.Concatenate()([person_features, cloth_features])
        
        # Transformer-like attention mechanism
        x = layers.Dense(256, activation='relu')(combined_features)
        x = layers.Dropout(0.3)(x)
        
        # Decoder with attention
        x = layers.Reshape((16, 16, 2))(x)
        x = layers.Conv2DTranspose(256, 3, strides=2, activation='relu', padding='same')(x)
        x = layers.Conv2DTranspose(128, 3, strides=2, activation='relu', padding='same')(x)
        x = layers.Conv2DTranspose(64, 3, strides=2, activation='relu', padding='same')(x)
        
        # Final output layer
        output = layers.Conv2D(3, 3, activation='sigmoid', padding='same')(x)

        # Create model
        model = Model(
            inputs=[person_input, cloth_input], 
            outputs=output
        )

        # Compile with advanced optimizer
        optimizer = tfa.optimizers.AdamW(
            learning_rate=self.config.LEARNING_RATE, 
            weight_decay=1e-5
        )

        model.compile(
            optimizer=optimizer,
            loss='mse',
            metrics=['mae']
        )

        return model

    def train(self, train_dataset, val_dataset):
        """
        Train the model with callbacks
        """
        # Callbacks
        callbacks = [
            tf.keras.callbacks.ModelCheckpoint(
                filepath=os.path.join(self.config.MODEL_SAVE_PATH, 'best_model.h5'),
                save_best_only=True,
                monitor='val_loss'
            ),
            tf.keras.callbacks.ReduceLROnPlateau(
                monitor='val_loss', 
                factor=0.2, 
                patience=5
            ),
            tf.keras.callbacks.EarlyStopping(
                monitor='val_loss', 
                patience=10, 
                restore_best_weights=True
            )
        ]

        # Enable mixed precision if configured
        if self.config.USE_MIXED_PRECISION:
            tf.keras.mixed_precision.set_global_policy('mixed_float16')

        # Train
        history = self.model.fit(
            train_dataset,
            validation_data=val_dataset,
            epochs=self.config.EPOCHS,
            callbacks=callbacks
        )

        return history

    def load_weights(self, path):
        """
        Load pre-trained weights
        """
        self.model.load_weights(path)
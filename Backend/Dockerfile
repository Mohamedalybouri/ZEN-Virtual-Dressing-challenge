# Use NVIDIA CUDA-enabled TensorFlow image
FROM tensorflow/tensorflow:2.12.0-gpu

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Verify GPU support
RUN python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Expose application port
EXPOSE 5000

# Set environment variables for TensorFlow GPU
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
ENV NVIDIA_VISIBLE_DEVICES=all

# Run the application
CMD ["python", "app.py"]

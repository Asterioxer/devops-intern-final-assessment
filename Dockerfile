# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy the application file
COPY hello.py .

# Run the application
CMD ["python", "hello.py"]

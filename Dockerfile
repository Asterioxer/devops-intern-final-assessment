# Base image: minimal Python runtime
FROM python:3.11-slim

# Runtime environment configuration
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create non-root user
RUN useradd --create-home appuser

# Set working directory
WORKDIR /app

# Copy application
COPY hello.py .

# Make script executable and set ownership
RUN chmod +x hello.py && chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Batch-style execution: container == application
ENTRYPOINT ["./hello.py"]

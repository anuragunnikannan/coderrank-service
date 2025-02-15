FROM python:3.11-slim

# Install dependencies for Docker and sshpass
RUN apt-get update && apt-get install sshpass openssh-client

# Set up working directory
WORKDIR /app

# Copy the application code
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir /home/codes

# Ensure scripts have the proper permissions
RUN chmod 777 ./java-execute.sh
RUN chmod 777 ./python-execute.sh

# Expose the Flask app port
EXPOSE 5000

# Default command to run the Python app
CMD ["python", "./app.py"]

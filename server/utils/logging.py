import logging

def setup_logging():
    logging.basicConfig(
    level=logging.DEBUG,  # Set default logging level
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),  # Logs will be shown in the console
        logging.FileHandler("server.log", mode='a')  # Also write logs to a file
    ]
)

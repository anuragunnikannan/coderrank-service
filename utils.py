import jwt, random, string, requests
import subprocess
import logging
import concurrent.futures


# Logging configuration
logging.basicConfig(format="{asctime} - {levelname} - {message}", style="{", datefmt="%Y-%m-%d %H:%M:%S")

def decode_token(token, secret):
    return jwt.decode(token, algorithms=["HS256"], key=secret)

def generate_random_secret_key(length):
    hexString = string.hexdigits
    return ''.join(random.choice(hexString) for i in range(length))

def check_is_admin(headers):
    response = requests.get("http://127.0.0.1:5000/verify-admin", headers=headers)
    is_admin = response.json()["is_admin"]
    return is_admin

def ping_url(url):
    try:
        # Use the ping command to ping the URL
        response = subprocess.run(["ping", "-n", "4", url], capture_output=True, text=True)
        
        # Check if the ping was successful
        if response.returncode == 0:
            print(f"Ping to {url} was successful.")
            print(response.stdout)
        else:
            print(f"Ping to {url} failed.")
            print(response.stderr)
    except Exception as e:
        print(f"An error occurred: {e}")

def timeout_function(language, filename, input, timeout):
    with concurrent.futures.ThreadPoolExecutor() as executor:
        future = executor.submit(code_exec_function(language, filename, input))
        try:
            return future.result(timeout=timeout)
        except concurrent.futures.TimeoutError:
            logging.error(f"Timeout of {timeout} seconds exceeded durring code execution")
            return None, None
    

def code_exec_function(language, filename, input):
    output = subprocess.run([language, filename], input=input, capture_output=True, timeout=5)
    stdout = output.stdout.decode().strip()
    stderr = output.stderr.decode().strip()

    return stdout, stderr
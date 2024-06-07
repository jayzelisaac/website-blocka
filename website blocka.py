import os

def block_website():
    # Set the path to the hosts file
    hosts_file = os.path.join(os.environ['SystemRoot'], 'System32', 'drivers', 'etc', 'hosts')

    # Prompt the user to input websites to block
    website = input("Enter the website you want to block (e.g., example.com): ")

    # Add website entry to block
    with open(hosts_file, 'a') as file:
        file.write("127.0.0.1    " + website + "\n")

    print(f"Website {website} blocked successfully!")

if __name__ == "__main__":
    block_website()

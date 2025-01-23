from ipaddress import IPv6Network
import numpy as np
import seaborn as sn

def generate_starlink_addresses(prefixes, subprefix_length=56, output_file="addresses.txt"):
    """
    Generate IPv6 addresses for the given prefixes and write them to a file.
    :param prefixes: List of base prefixes (e.g., ['2605:59ca:1300::/40'])
    :param subprefix_length: Subnet size to enumerate (default is /56)
    :param output_file: File to save the generated addresses
    """
    with open(output_file, "w") as file:
        for base_prefix in prefixes:
            base_network = IPv6Network(base_prefix)
            print(f"Generating addresses for {base_prefix}")
            
            # Generate all /56 sub-prefixes
            for subprefix in base_network.subnets(new_prefix=subprefix_length):
                # Fix the 57th to 127th bits to 0, 128th bit to 1
                addr = f"{subprefix.network_address}1"
                file.write(addr + "\n")

# Define prefixes for Minneapolis
prefixes = ['2605:59ca:1300::/40', '2605:59ca:1600::/40']

# Generate addresses and write to file
generate_starlink_addresses(prefixes)


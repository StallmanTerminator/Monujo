#!/usr/bin/env python3
import os
import scrypt
import getpass
import argparse
import hashlib
from Crypto.Cipher import AES


WALLET_VERSION = bytes([0x1])
WALLET_NORMAL = bytes([0x0])
WALLET_ENCRYPT = bytes([0x1])


def secinput(prompt):
    data = None
    verify = None

    while True:
        data = getpass.getpass(prompt)
        verify = getpass.getpass("(verify) " + prompt)
        if verify == data:
            return data
        else:
            print("Not match :<")


def store(dest, seed, enc=None):
    with open(dest, 'wb') as fp:
        fp.write(b'MJO')
        fp.write(WALLET_VERSION)
        if not enc:
            fp.write(WALLET_NORMAL)
            fp.write(seed)
        else:
            fp.write(WALLET_ENCRYPT)
            nonce = os.urandom(12)
            fp.write(nonce)
            cipher = AES.new(enc, AES.MODE_GCM, nonce=nonce)
            ciphertext, tag = cipher.encrypt_and_digest(seed)
            fp.write(ciphertext)
            fp.write(tag)
    print("{}: created".format(dest))


def main(args):
    password = secinput("password:")
    salt = secinput("salt:")

    seed = scrypt.hash(password, salt, args.N, args.R, args.P, 32)

    if args.encrypt:
        key = secinput("encryption key:").encode('utf-8')
        store('wallet.dat', seed, hashlib.sha256(key).digest())
    else:
        store('wallet.dat', seed)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Monujo tools')
    parser.add_argument('-N', type=int, default=4096)
    parser.add_argument('-R', type=int, default=16)
    parser.add_argument('-P', type=int, default=1)
    parser.add_argument('--encrypt', action='store_true', default=False)
    main(parser.parse_args())

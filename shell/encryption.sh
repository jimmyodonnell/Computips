#!/usr/bin/env bash

# You can use openssl to encrypt and decrypt using key based symmetric ciphers. For example:

openssl enc -in foo.bar \
    -aes-256-cbc \
    -pass stdin > foo.bar.enc

# This encrypts foo.bar to foo.bar.enc (you can use the -out switch to specify the output file, instead of redirecting stdout as above) using a 256 bit AES cipher in CBC mode. There are various other ciphers available (see man enc). The command will then wait for you to enter a password and use that to generate an appropriate key. You can see the key with -p or use your own in place of a password with -K (actually it is slightly more complicated than that since an initialization vector or source is needed, see man enc again). If you use a password, you can use the same password to decrypt, you do not need to look at or keep the generated key.

# To decrypt this:

openssl enc -in foo.bar.enc \
    -d -aes-256-cbc \
    -pass stdin > foo.bar

# Notice the -d. See also man openssl.


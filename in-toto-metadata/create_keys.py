#!/usr/bin/env python

from toto.models.layout import Layout, Step, Inspection 
import toto.util

if __name__:

    # Get keys
    toto.util.generate_and_write_rsa_keypair("santiago")
    toto.util.generate_and_write_rsa_keypair("justin")

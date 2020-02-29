%load_ext autoreload
%autoreload 2
print()
print('================')
print('autoload enabled')
print('================')
print()

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Copy to clipboard
# inspired by https://blog.michaelyin.info/send-content-to-clipboard-in-ipython/
def clip(var):
    import os
    os.system(f'printf "{var}" | pbcopy')

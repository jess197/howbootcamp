#%%
#imports 
import requests
import json

#%%
url = 'https://economia.awesomeapi.com.br/last/USD-BRL'
ret = requests.get(url)

#%%
if ret: 
    print(ret)
else:
    print('Failed')
# %%
dolar = json.loads(ret.text)['USDBRL']

# %%
print ( f" 20 dolares hoje custam {float(dolar['bid']) * 20} reais")
# %%

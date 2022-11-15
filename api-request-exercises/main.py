#%%
#imports 
import requests
import json
# %%

def error_check(func):
    def inner_func(*args, **kargs):
        try:
            func(*args, **kargs)
        except: 
            print(f"{func.__name__} falhou")
    return inner_func

@error_check
def cotacao(valor, moeda):
    url = f'https://economia.awesomeapi.com.br/last/{moeda}'
    ret = requests.get(url)
    dolar = json.loads(ret.text)[moeda.replace('-','')]
    print(f"{valor} {moeda[:3]} hoje custam {float(dolar['bid']) * valor} {moeda[-3:]}")


#%%
cotacao(20, 'USD-BRL')
cotacao(20, 'BTC-BRL')
cotacao(20, 'EUR-BRL')
cotacao(20, 'RPL-BRL')
cotacao(20, 'JPY-BRL')
# %%


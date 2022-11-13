- To create a venv envoirment with docker 
  ``` python3 -m venv venv ``` 
  ``` pip freeze > requirements.txt ``` 
  ``` source venv/bin/activate ```
  ``` docker build -t fake_events . ```
  ``` docker run fake_events ```   
  ```docker images ```
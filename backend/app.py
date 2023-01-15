from collections import Counter
from flask import Flask, request
import os

app = Flask(__name__)  
 
@app.route('/request', methods =["GET", "POST"])
def request_site():
    if request.method == "POST":
        try:
            data = request.get_json()['data']
            app.logger.info(f'This is request output {dict(Counter(data))}')
        except:
            return {}
        
            # text processing


        return dict(Counter(data))
    return {}
 

if __name__=='__main__':
    print(os.environ)
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080)))

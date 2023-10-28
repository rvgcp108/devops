import datetime
import psutil
from flask import Flask, render_template

app = Flask(__name__)
@app.route('/')
def index():
    cpu_percent = psutil.cpu_percent()
    mem_percent = psutil.virtual_memory().percent
    msg = None
    if cpu_percent > 90 or mem_percent >80:
        msg = "CPU and Memory utilization is very High"
    #return f"Cpu utilication {cpu_percent} and Memory utilization {mem_percent}"
    return render_template("index.html",cpu_metric=cpu_percent,mem_metric=mem_percent,message=msg,utc_dt=datetime.datetime.utcnow())
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
    


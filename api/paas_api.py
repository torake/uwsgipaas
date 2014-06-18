from flask import *
import json, socket, subprocess, os
app = Flask(__name__)

def find_unused_port():
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  s.bind(('0.0.0.0', 0))
  addr, port = s.getsockname()
  s.close()
  return port

@app.route("/apps", methods=['GET'])
def list_apps():
  return make_response(json.dumps(os.listdir("/repos/")), 200)

@app.route("/apps/<name>", methods=['DELETE'])
def delete(name):
  subprocess.call(["./deleteapp.sh", name])
  return make_response("App id %s deleted." % name, 200)

@app.route("/apps/<name>", methods=['GET'])
def i_app(name):
  try:
    pid = int(open('/var/run/apps/%s.pid' % name).read().rstrip())
    port = int(open('/var/run/apps/%s.port' % name).read().rstrip())
  except:
    return make_response("App id %s not existing" % name, 404)
  return make_response("%s is running on port: %s, pid: %d" % (name, port, pid), 200)

@app.route("/apps/<name>", methods=['PUT'])
def create(name):
  port = find_unused_port()
  ret = subprocess.call(["./runapp.sh", name, json.loads(request.data)["git-url"], str(port)], close_fds=True)
  if ret == 0:
    return make_response(str(port),  201)
  else:
    return make_response("Failed to add application.", 409)

if __name__ == "__main__":
  app.run(host='0.0.0.0', debug=True)

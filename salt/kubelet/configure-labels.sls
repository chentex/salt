include:
  - kubectl-config

{% from '_macros/kubectl.jinja' import kubectl with context %}

# TODO: onlyif's need doing
# TODO: check_cmd's need removing

{% if "kube-master" in salt['grains.get']('roles', []) %}
{{ kubectl("set-master-label",
           "label node --overwrite " + grains['nodename'] + " node-role.kubernetes.io/master=",
           onlyif="/bin/true") }}
{% elif "kube-minion" in salt['grains.get']('roles', []) %}
{{ kubectl("set-worker-label",
           "label node --overwrite " + grains['nodename'] + " node-role.kubernetes.io/worker=",
           onlyif="/bin/true") }}
{% else %}
{{ kubectl("clear-master-label",
           "label node --overwrite " + grains['nodename'] + " node-role.kubernetes.io/master-",
           onlyif="/bin/true",
           check_cmd="/bin/true") }}
{% endif %}
